        SELECT /*issuelog single*/
                  issuelog.*
                  , GROUP_CONCAT(
                        DISTINCT
                        CONCAT(issuelog_type.type_id, ':', is_type.inactive, ':', is_type.color, ':', is_type.name)
                        ORDER BY issuelog_type.id
                        SEPARATOR '#@#@#'
                    ) AS issue_type
                  , COALESCE(issue_board.name, '') AS issue_board_name
                  , COALESCE(issue_board_column.name, '') AS issue_board_column_name
                  , GROUP_CONCAT(DISTINCT
                        CONCAT(
                            issuelog_x_board.id, ':',
                            issue_board.id, ':',
                            COALESCE(issue_board_column.id, ''), ':',
                            issuelog_x_board.issue_board_column_ordering, ':',
                            issue_board.name, '#|#',
                            COALESCE(issue_board_column.name, '')
                        )
                        ORDER BY issuelog_x_board.id
                        SEPARATOR '<<|>>'
                    ) AS issuelog_boards
                  , GROUP_CONCAT(DISTINCT ila.username) as all_access_user
                  , GROUP_CONCAT(DISTINCT CONCAT(isd.department_id, '$#$#$', empd.name, '$#$#$', empd.deleted) SEPARATOR ', ') as department_id
                  , GROUP_CONCAT(DISTINCT ipu.username) AS ping_list
                  , IF(auction.auction_number, auction.auction_number, issuelog.obj_id) AS `number`
                  , IF(auction.txnid, auction.txnid, '') AS `txnid`
                  , COALESCE(users.name, resp_external_user.name) AS user_name
                  , COALESCE(users.email, resp_external_user.email) AS resp_email
                  , IF(users.use_as_shipping_company = 4, 1, 0) AS resp_massuser
                  , users_solving.name AS solving_user_name
                  , users_solving.username AS solving_username
                  , COUNT(super_dep.id) AS allow_change_solving
                  , IF(users_solving.use_as_shipping_company = 4, 1, 0) AS solving_massuser
                  , users_solving.email as solving_user_email
                  , solving_department.direct_super_username solv_direct
                  , solving_department.main_super_username solv_main
                  , GROUP_CONCAT(DISTINCT empd.name SEPARATOR ', ') AS department_name
                  , (
                      SELECT CONCAT(COALESCE(users.name, external_user.name, ''), ' on ', tl_rest.Updated)
                        FROM total_log_issuelog AS tl_rest
                        LEFT JOIN users
                               ON users.id = tl_rest.username_id
                              AND tl_rest.username_id > 0
                        LEFT JOIN public_issue.external_user AS external_user
                               ON external_user.id = ABS(tl_rest.username_id)
                              AND tl_rest.username_id < 0
                       WHERE tl_rest.TableID = issuelog.id
                         AND  `tl_rest`.`field_name_id` = 5751 /* restricted_access */ 
                       ORDER BY tl_rest.ID DESC
                       LIMIT 1
                    ) AS last_restricted_updated
                  , (
                      SELECT CONCAT(Updated, ',', COALESCE(users.name, external_user.name, ''))
                        FROM total_log_issuelog AS tl
                        LEFT JOIN users
                               ON tl.username_id = users.id
                              AND tl.username_id > 0
                        LEFT JOIN public_issue.external_user AS external_user
                               ON external_user.id = ABS(tl.username_id)
                              AND tl.username_id < 0
                       WHERE tl.TableID = issuelog.id
                         AND  `tl`.`field_name_id` = 1009 /* recurring */ 
                       ORDER BY tl.ID DESC
                       LIMIT 1
                  ) AS last_recurring_info
                  , (
                      SELECT CONCAT(COALESCE(users.name, external_user.name, ''), ' on ', Updated)
                        FROM total_log_issuelog AS tl
                        LEFT JOIN users
                               ON tl.username_id = users.id
                              AND tl.username_id > 0
                        LEFT JOIN public_issue.external_user AS external_user
                               ON external_user.id = ABS(tl.username_id)
                              AND tl.username_id < 0
                       WHERE tl.TableID = issuelog.id
                         AND  `tl`.`field_name_id` = 13537 /* issue_priority */ 
                       ORDER BY tl.ID DESC
                       LIMIT 1
                  ) AS issue_priority_changed_by
                  , (
                      SELECT CONCAT(COALESCE(users.name, external_user.name, ''), ' on ', Updated)
                        FROM total_log_issuelog AS tl
                        LEFT JOIN users
                               ON tl.username_id = users.id
                              AND tl.username_id > 0
                        LEFT JOIN public_issue.external_user AS external_user
                               ON external_user.id = ABS(tl.username_id)
                              AND tl.username_id < 0
                       WHERE tl.TableID = issuelog.id
                         AND  `tl`.`field_name_id` = 1010 /* due_date */ 
                       ORDER BY tl.ID DESC
                       LIMIT 1
                  ) AS due_date_changed_by
                  , (
                      SELECT CONCAT(Updated, ',', IFNULL(u.name, ''))
                      FROM total_log_issuelog tl
                      LEFT JOIN users u ON tl.username_id = u.id
                      WHERE 
                        tl.TableID = issuelog.id AND  `tl`.`field_name_id` IN (13461, 13462, 13463) /* from_warehouse_id_setting, to_warehouse_id_setting, wwo_id_setting */ 
                      ORDER BY tl.Updated DESC
                      LIMIT 1
                  ) AS last_add_wwo_setting_change
                  , (
                    SELECT GROUP_CONCAT(
                        CONCAT(IFNULL(ib.issue_board_id, 0), '%$%$%', COALESCE(users.name, external_user.name, ''), ' on ', tl.Updated) 
                        ORDER BY tl.id DESC
                        SEPARATOR '#$#$#'
                    )
                    FROM total_log_issuelog_x_board tl
                    LEFT JOIN users
                        ON users.id = tl.username_id
                        AND tl.username_id > 0
                    LEFT JOIN public_issue.external_user AS external_user
                        ON external_user.id = ABS(tl.username_id)
                        AND tl.username_id < 0
                    JOIN issuelog_x_board ib ON ib.id = tl.TableID
                    WHERE 
                        tl.id IN (
                            SELECT 
                                MAX(tli.id) tl_id
                            FROM issuelog_x_board ib
                            JOIN total_log_issuelog_x_board tli ON tli.TableID = ib.id
                            WHERE  `tli`.`field_name_id` = 13544 /* issue_board_id */  AND ib.issuelog_id = issuelog.id
                            GROUP BY tli.TableID
                        ) 
                    GROUP BY ib.issuelog_id
                  ) AS last_board_change
                  , (
                    SELECT GROUP_CONCAT(
                        CONCAT(IFNULL(ib.issue_board_id, 0), '%$%$%', COALESCE(users.name, external_user.name, ''), ' on ', tl.Updated) 
                        ORDER BY tl.id DESC
                        SEPARATOR '#$#$#'
                    )
                    FROM total_log_issuelog_x_board tl
                    LEFT JOIN users
                        ON users.id = tl.username_id
                        AND tl.username_id > 0
                    LEFT JOIN public_issue.external_user AS external_user
                        ON external_user.id = ABS(tl.username_id)
                        AND tl.username_id < 0
                    JOIN issuelog_x_board ib ON ib.id = tl.TableID
                    WHERE 
                        tl.id IN (
                            SELECT 
                                MAX(tli.id) tl_id
                            FROM issuelog_x_board ib
                            JOIN total_log_issuelog_x_board tli ON tli.TableID = ib.id
                            WHERE  `tli`.`field_name_id` = 13545 /* issue_board_column_id */  AND ib.issuelog_id = issuelog.id
                            GROUP BY tli.TableID
                        ) 
                    GROUP BY ib.issuelog_id
                  ) AS last_board_column_change
                  , (
                      SELECT CONCAT(COALESCE(users.name, external_user.name, ''), ' on ', tl.Updated)
                        FROM total_log AS tl
                        LEFT JOIN users
                               ON users.id = tl.username_id
                              AND tl.username_id > 0
                        LEFT JOIN public_issue.external_user AS external_user
                               ON external_user.id = ABS(tl.username_id)
                              AND tl.username_id < 0
                       WHERE tl.TableID IN (SELECT id FROM issuelog_type WHERE issuelog_id = issuelog.id)
                         AND tl.New_value = issuelog.id
                         AND tl.Old_value IS NULL
                         AND  `tl`.`table_name_id` = 247 /* issuelog_type */ 
                         AND  `tl`.`field_name_id` = 609 /* issuelog_id */  
                       ORDER BY tl.ID DESC
                       LIMIT 1
                  ) AS last_issue_type_change
                  , (
                      SELECT CONCAT(users.name, ' on ', tl.Updated)
                      FROM total_log tl
                      JOIN users ON users.id = tl.username_id
                      WHERE 
                          TableID IN (SELECT id FROM issuelog_access WHERE issuelog_id = issuelog.id) AND  `tl`.`table_name_id` = 1073 /* issuelog_access */  AND  `tl`.`field_name_id` = 88 /* username */  
                      ORDER BY tl.id DESC
                      LIMIT 1
                  ) AS last_access_list_change 
                  , tl.Updated AS added_time
                  , users_tl.name AS added_person
                  , users_tl.username AS added_person_username
                  , users_tl.deleted AS added_person_deleted
                  , IF(users_tl.deleted, IF(added_user_direct.deleted, IF(added_user_main.deleted, users_tl.username, added_user_main.username), added_user_direct.username), users_tl.username) AS added_person_if_deleted
                  , IF(IF(users_tl.deleted, IF(added_user_direct.deleted, IF(added_user_main.deleted, users_tl.use_as_shipping_company, added_user_main.use_as_shipping_company), added_user_direct.use_as_shipping_company), users_tl.use_as_shipping_company) = 4, 1, 0) AS added_person_massuser
                  , added_person_department.name AS added_person_department_name
                  , users_tl_st.name AS change_by
                  , tl_st.Updated AS change_time
                  , GROUP_CONCAT(DISTINCT tl_st_open.Updated ORDER BY tl_st_open.id) AS open_dates
                  , GROUP_CONCAT(DISTINCT tl_st_not_open.Updated ORDER BY tl_st_not_open.id) AS not_open_dates,
                    (SELECT COUNT(*) FROM issue_checkpoint ic WHERE ic.issuelog_id = issuelog.id) as checkpoints_total,
                    (SELECT COUNT(*) FROM issue_checkpoint ic WHERE ic.issuelog_id = issuelog.id AND ic.done = 1) as checkpoints_done,
                    (
             SELECT COUNT(*)
               FROM close_notif
              WHERE close_notif.obj_id = issuelog.id
                AND close_notif.obj = 'issuelog'
                AND close_notif.username = 'arthurpronota'
            ) AS close_notif,
                    CASE issuelog.obj
                        WHEN 'auction' THEN 'Auftrag: 'WHEN'shop_catalogue' THEN 'Shop catalogue: 'WHEN'shipping_plan' THEN 'Shipping plan: 'WHEN'sa' THEN 'SA: 'WHEN'offer' THEN 'Offer: 'WHEN'article' THEN CONCAT('Article: |', (
                                                                  SELECT GROUP_CONCAT(employee.username)
                                                                    FROM employee
                                                                   WHERE inactive = 0
                                                                     AND id IN (
                                                                                 SELECT emp_id
                                                                                   FROM op_company_emp
                                                                                  WHERE type = 'purch'
                                                                                    AND company_id = (SELECT company_id FROM article WHERE article_id = issuelog.obj_id and admin_id = 0))
                                                                   ORDER BY name, name2))WHEN'supplier' THEN 'Supplier: 'WHEN'rma' THEN 'Ticket: 'WHEN'op_order' THEN 'OP Order: 'WHEN'route' THEN 'Route: 'WHEN'rating' THEN 'Rating: 'WHEN'insurance' THEN 'Insurance: 'WHEN'shippingInvoiceResults' THEN 'Shipping invoice: 'WHEN'monitoredShippingPrices' THEN 'Monitored shipping price: 'WHEN'wwo' THEN 'WWO: 'WHEN'car' THEN 'Car: 'WHEN'fork_lift' THEN 'Forklift: 'WHEN'op_order_container' THEN 'Container: 'WHEN'palette' THEN 'Palette: 'WHEN'shippingMethod' THEN 'Shipping Method: 'WHEN'shipping_cost' THEN 'Shipping price: 'WHEN'newsletter' THEN 'Newsletter: '
                    END AS where_did,
                    CASE issuelog.obj
                        WHEN 'auction' THEN CONCAT('auction.php?number=',auction.auction_number,'&txnid=',auction.txnid)WHEN'shop_catalogue' THEN CONCAT('shop_cat.php?id=0&shop_id=1&cat_id=',issuelog.obj_id)WHEN'shipping_plan' THEN CONCAT('shipping_plan.php?id=',issuelog.obj_id)WHEN'sa' THEN CONCAT('react/condensed/condensed_sa/',issuelog.obj_id,'/')WHEN'offer' THEN CONCAT('offer.php?id=',issuelog.obj_id)WHEN'article' THEN CONCAT('article.php?original_article_id=',issuelog.obj_id)WHEN'supplier' THEN CONCAT('op_suppliers.php?company_id=',issuelog.obj_id)WHEN'rma' THEN CONCAT('rma.php?rma_id=',issuelog.obj_id,'&number=',rma.auction_number,'&txnid=',rma.txnid)WHEN'op_order' THEN CONCAT('op_order.php?id=',issuelog.obj_id)WHEN'route' THEN CONCAT('route.php?id=',issuelog.obj_id)WHEN'rating' THEN CONCAT('rating_case.php?id=',issuelog.obj_id)WHEN'insurance' THEN CONCAT('insurance.php?id=',issuelog.obj_id)WHEN'shippingInvoiceResults' THEN CONCAT('react/shipping_pages/invoice_settings/result/',issuelog.obj_id,'/')WHEN'monitoredShippingPrices' THEN CONCAT('react/logs/shipping_price_monitor/',issuelog.obj_id,'/')WHEN'wwo' THEN CONCAT('ware2ware_order.php?id=',issuelog.obj_id)WHEN'car' THEN CONCAT('car.php?id=',issuelog.obj_id)WHEN'fork_lift' THEN CONCAT('fork_lift.php?id=',issuelog.obj_id)WHEN'op_order_container' THEN CONCAT('op_order.php?id=',
                (SELECT order_id FROM op_order_container ooc WHERE ooc.id=issuelog.obj_id LIMIT 1), '&filter_container_id=', issuelog.obj_id)WHEN'palette' THEN CONCAT('parcel_barcodes.php?filter[code]=',issuelog.obj_id)WHEN'shippingMethod' THEN CONCAT('method.php?id=', issuelog.obj_id)WHEN'shipping_cost' THEN CONCAT('shipping_price.php?id=', issuelog.obj_id)WHEN'newsletter' THEN CONCAT('news_email.php?id=', issuelog.obj_id)
                    END AS url,
                    CASE issuelog.obj
                        WHEN 'supplier' THEN sup.name
                        WHEN 'car' THEN CONCAT('Car: ', issuelog.obj_id, ' (', (SELECT cars.name FROM cars WHERE cars.id = issuelog.obj_id LIMIT 1) ,')')
                        WHEN 'fork_lift' THEN CONCAT('Forklift: ', issuelog.obj_id, ' (', (SELECT fork_lift.model FROM fork_lift WHERE fork_lift.id = issuelog.obj_id LIMIT 1) ,')')
                        WHEN 'shippingInvoiceResults' THEN CONCAT ('Shipping invoice ', ail.name)
                        WHEN 'op_order_container' THEN CONCAT('OP Order: ', (SELECT order_id FROM op_order_container ooc WHERE ooc.id=issuelog.obj_id LIMIT 1))
                        WHEN 'palette' THEN CONCAT('Palette: ', (SELECT parcel FROM vparcel_barcode WHERE vparcel_barcode.id=issuelog.obj_id LIMIT 1))
                        WHEN 'shippingMethod' THEN CONCAT('Shipping method: ', (SELECT company_name FROM shipping_method WHERE shipping_method_id=issuelog.obj_id))
                        WHEN 'shipping_cost' THEN CONCAT('Shipping price: ', issuelog.obj_id)
                    END AS url_text,
                    ipd.user_id AS userid,
                    COALESCE(ipd.days, 21) AS ping_days
                  , MAX(is_type.status_by_solving) AS status_by_solving
                  , MAX(is_type.solving_changeable_by_any_user) AS solving_changeable_by_any_user
                  , MAX(is_type.ping_changeable_by_any_user) AS ping_changeable_by_any_user
                  , MAX(is_type.status_changeable_by_any_user) status_changeable_by_any_user
                  , MAX(is_type.priority_changeable_by_any_user) AS priority_changeable_by_any_user
                  , MAX(is_type.due_date_changeable_by_any_user) AS due_date_changeable_by_any_user
                  , MAX(is_type.restricted_access) AS restricted_access_automatic
                  , IF(MAX(is_type.restricted_access) + issuelog.restricted_access, 1, 0) AS restricted_access
                  , IF(MAX(is_type.subject_in_url), 1, 0) AS subject_in_url
                  , IF(MAX(is_type.generate_label), 1, 0) AS generate_label
                  , issue_priority.id AS issue_priority 
                  , issue_priority.name AS issue_priority_name
                  , issue_priority.color AS issue_priority_color
                  , IFNULL(issuelog_marked_x_user.favorite, 0) AS favorite
          FROM issuelog
          JOIN issue_priority ON issue_priority.id = issuelog.issue_priority
                  LEFT JOIN users ON users.username = issuelog.resp_username
                  LEFT JOIN public_issue.external_user AS resp_external_user
                         ON resp_external_user.id = issuelog.resp_external_user_id
                        AND resp_external_user.passhash IS NOT NULL
                  LEFT JOIN users users_solving ON users_solving.username = issuelog.solving_resp_username
                  LEFT JOIN auction ON auction.id = issuelog.obj_id AND issuelog.obj = 'auction'
                  LEFT JOIN rma ON rma.rma_id = issuelog.obj_id AND issuelog.obj = 'rma'
                  LEFT JOIN auction auction_rma ON rma.auction_number = auction_rma.auction_number AND rma.txnid = auction_rma.txnid
                  LEFT JOIN orders ON auction.auction_number = orders.auction_number and auction.txnid = orders.txnid
                  LEFT JOIN orders orders_rma ON rma.auction_number = orders_rma.auction_number and rma.txnid = orders_rma.txnid
                  LEFT JOIN auction_par_varchar ON auction.auction_number = auction_par_varchar.auction_number AND auction.txnid = auction_par_varchar.txnid AND auction_par_varchar.`key` = 'country_shipping'
                  LEFT JOIN auction_par_varchar apv_rma ON rma.auction_number = apv_rma.auction_number AND rma.txnid = apv_rma.txnid AND apv_rma.`key` = 'country_shipping'
                  LEFT JOIN total_log_issuelog tl ON tl.TableID = issuelog.id
                        AND  `tl`.`field_name_id` = 2 /* id */ 
                  LEFT JOIN total_log_issuelog tl_st ON tl_st.TableID = issuelog.id
                        AND  `tl_st`.`field_name_id` = 132 /* status */ 
                  LEFT JOIN total_log_issuelog tl_st_open ON tl_st_open.TableID = issuelog.id
                        AND tl_st_open.New_value = 'open'
                        AND  `tl_st_open`.`field_name_id` = 132 /* status */ 
                  LEFT JOIN total_log_issuelog tl_st_not_open ON tl_st_not_open.TableID = issuelog.id
                        AND tl_st_not_open.New_value <> 'open'
                        AND  `tl_st_not_open`.`field_name_id` = 132 /* status */ 
                  LEFT JOIN users users_tl ON users_tl.id = tl.username_id
                  LEFT JOIN employee AS added_person_employee ON added_person_employee.username = users_tl.username
                  LEFT JOIN emp_department AS added_person_department ON added_person_department.id = added_person_employee.department_id
                  LEFT JOIN users added_user_direct ON added_user_direct.username = added_person_department.direct_super_username
                  LEFT JOIN users added_user_main ON added_user_main.username = added_person_department.main_super_username
                  LEFT JOIN employee AS solving_employee ON solving_employee.username = users_solving.username
                  LEFT JOIN emp_department AS solving_department ON solving_department.id = solving_employee.department_id
                  LEFT JOIN emp_department super_dep ON 
                        'arthurpronota' IN (super_dep.main_super_username, super_dep.direct_super_username) AND
                        super_dep.deleted = 0
                  LEFT JOIN users users_tl_st ON users_tl_st.id = tl_st.username_id
                  LEFT JOIN issuelog_type ON issuelog_type.issuelog_id = issuelog.id
                  LEFT JOIN issue_type is_type ON is_type.id = issuelog_type.type_id
                  LEFT JOIN issuelog_x_board ON issuelog_x_board.issuelog_id = issuelog.id AND issuelog_x_board.issue_board_id IS NOT NULL
                  LEFT JOIN issue_board ON issue_board.id = issuelog_x_board.issue_board_id
                  LEFT JOIN issue_board_column ON issue_board_column.id = issuelog_x_board.issue_board_column_id
                  LEFT JOIN op_company sup ON sup.id = issuelog.obj_id AND issuelog.obj = 'supplier'
                  LEFT JOIN issuelog_dep isd ON isd.issuelog_id = issuelog.id
                  LEFT JOIN emp_department empd ON empd.id IN (isd.department_id)
                  LEFT JOIN autoship_import_log ail ON ail.id = issuelog.obj_id
                  LEFT JOIN issue_ping_days ipd ON ipd.obj_id = issuelog.id AND ipd.obj = 'issuelog'
                  LEFT JOIN issuelog_access ila ON issuelog.id = ila.issuelog_id
                  LEFT JOIN users u_ila ON u_ila.username = ila.username
                  LEFT JOIN issue_ping_user ipu ON ipu.obj_id = issuelog.id AND ipu.obj = 'issuelog'
                  LEFT JOIN issuelog_marked_x_user
                         ON issuelog_marked_x_user.issuelog_id = issuelog.id
                        AND issuelog_marked_x_user.username = 'arthurpronota'
         WHERE issuelog.id = 10
         GROUP BY issuelog.id
