DROP PROCEDURE IF EXISTS get_issuelog;

DELIMITER $$

CREATE PROCEDURE get_issuelog(
    issuelog_id INT,
    curent_user VARCHAR(50))
proc_label: BEGIN
    -- Initialize variables
    SET @issuelog.id = NULL;
    SET @issuelog.issue_priority = NULL;
    SET @issuelog.resp_username = NULL;
    SET @solving_employee.department_id = NULL;
    SET @added_person_employee.department_id = NULL;
    SET @users_solving.username = NULL;
    SET @users_tl.deleted = NULL;
    SET @added_user_direct.deleted = NULL;
    SET @added_user_main.deleted = NULL;
    SET @users_tl.username = NULL;
    SET @added_user_main.username = NULL;
    SET @added_user_direct.username = NULL;
    SET @issuelog.issue = NULL;
    SET @issuelog.decision = NULL;
    SET @issuelog.comment = NULL;
    SET @issuelog.corrective_action = NULL;
    SET @issuelog.closed = NULL;
    SET @issuelog.solving_resp_username = NULL;
    SET @issuelog.obj = NULL;
    SET @issuelog.obj_id = NULL;
    SET @issuelog.inactive = NULL;
    SET @issuelog.status = NULL;
    SET @issuelog.recurring = NULL;
    SET @issuelog.due_date = NULL;
    SET @issuelog.checklist_title = NULL;
    SET @issuelog.employee_position = NULL;
    SET @issuelog.restricted_access = NULL;
    SET @issuelog.from_warehouse_id_setting = NULL;
    SET @issuelog.to_warehouse_id_setting = NULL;
    SET @issuelog.wwo_id_setting = NULL;
    SET @issuelog.issue_board = NULL;
    SET @issuelog.issue_board_column = NULL;
    SET @issuelog.issue_board_column_ordering = NULL;
    SET @issuelog.resp_external_user_id = NULL;
    SET @issue_type = NULL;
    SET @issue_board_name = NULL;
    SET @issue_board_column_name = NULL;
    SET @issuelog_boards = NULL;
    SET @all_access_user = NULL;
    SET @department_id = NULL;
    SET @ping_list = NULL;
    SET @number = NULL;
    SET @txnid = NULL;
    SET @user_name = NULL;
    SET @resp_email = NULL;
    SET @resp_massuser = NULL;
    SET @solving_user_name = NULL;
    SET @solving_username = NULL;
    SET @allow_change_solving = NULL;
    SET @solving_massuser = NULL;
    SET @solving_user_email = NULL;
    SET @solv_direct = NULL;
    SET @solv_main = NULL;
    SET @department_name = NULL;
    SET @last_restricted_updated = NULL;
    SET @last_recurring_info = NULL;
    SET @issue_priority_changed_by = NULL;
    SET @due_date_changed_by = NULL;
    SET @last_add_wwo_setting_change = NULL;
    SET @last_board_change = NULL;
    SET @last_board_column_change = NULL;
    SET @last_issue_type_change = NULL;
    SET @last_access_list_change = NULL;
    SET @added_time = NULL;
    SET @added_person = NULL;
    SET @added_person_username = NULL;
    SET @added_person_deleted = NULL;
    SET @added_person_if_deleted = NULL;
    SET @added_person_massuser = NULL;
    SET @added_person_department_name = NULL;
    SET @change_by = NULL;
    SET @change_time = NULL;
    SET @open_dates = NULL;
    SET @not_open_dates = NULL;
    SET @checkpoints_total = NULL;
    SET @checkpoints_done = NULL;
    SET @close_notif = NULL;
    SET @where_did = NULL;
    SET @url = NULL;
    SET @url_text = NULL;
    SET @userid = NULL;
    SET @ping_days = NULL;
    SET @status_by_solving = NULL;
    SET @solving_changeable_by_any_user = NULL;
    SET @ping_changeable_by_any_user = NULL;
    SET @status_changeable_by_any_user = NULL;
    SET @priority_changeable_by_any_user = NULL;
    SET @due_date_changeable_by_any_user = NULL;
    SET @restricted_access_automatic = NULL;
    SET @restricted_access = NULL;
    SET @subject_in_url = NULL;
    SET @generate_label = NULL;
    SET @issue_priority = NULL;
    SET @issue_priority_name = NULL;
    SET @issue_priority_color = NULL;
    SET @favorite = NULL;
    SET @resp_external_user.email = NULL;
    SET @resp_external_user.name = NULL;
    SET @auction.txnid = NULL;
    SET @auction.auction_number = NULL;
    SET @rma.auction_number = NULL;
    SET @rma.txnid = NULL;
    SET @orders_rma.auction_number = NULL;
    SET @orders_rma.txnid = NULL;
    SET @tl.ID = NULL;
    SET @tl.username_id = NULL;
    SET @tl_st.username_id = NULL;
    SET @users_tl.use_as_shipping_company = NULL;
    SET @added_person_department.direct_super_username = NULL;
    SET @added_person_department.main_super_username = NULL;
    SET @added_user_direct.use_as_shipping_company = NULL;
    SET @added_user_main.use_as_shipping_company = NULL;
    SET @sup.name = NULL;
    SET @ail.name = NULL;
    SET @ipd.days = NULL;
    SET @users.name_tmp = NULL;
    SET @external_user.name_ = NULL;
    SET @tl_rest.username_id = NULL;
    SET @tl_rest.Updated = NULL;
    SET @users.name_ = NULL;
    SET @tl_tmp.username_id = NULL;
    SET @tl_tmp.Updated = NULL;
    SET @u.name_ = NULL;
    SET @tl.id_ = NULL;
    SET @tl_tmp.Updated_ = NULL;
    SET @tl_tmp.username_id_ = NULL;
    SET @company_id_tmp = NULL;
    SET @order_id_ = NULL;
    SET @cars.name_ = NULL;
    SET @fork_lift.model_ = NULL;
    SET @ooc.order_id_ = NULL;
    SET @vparcel_barcode.parcel_ = NULL;
    SET @shipping_method.company_name_ = NULL;

    -- Get basic issue log information
    SELECT 
        id,
        resp_username,
        issue,
        decision,
        comment,
        corrective_action,
        closed,
        solving_resp_username,
        obj,
        obj_id,
        inactive,
        status,
        recurring,
        due_date,
        checklist_title,
        employee_position,
        issue_priority,
        restricted_access,
        from_warehouse_id_setting,
        to_warehouse_id_setting,
        wwo_id_setting,
        issue_board,
        issue_board_column,
        issue_board_column_ordering,
        resp_external_user_id
    INTO 
        @issuelog.id,
        @issuelog.resp_username,
        @issuelog.issue,
        @issuelog.decision,
        @issuelog.comment,
        @issuelog.corrective_action,
        @issuelog.closed,
        @issuelog.solving_resp_username,
        @issuelog.obj,
        @issuelog.obj_id,
        @issuelog.inactive,
        @issuelog.status,
        @issuelog.recurring,
        @issuelog.due_date,
        @issuelog.checklist_title,
        @issuelog.employee_position,
        @issuelog.issue_priority,
        @issuelog.restricted_access,
        @issuelog.from_warehouse_id_setting,
        @issuelog.to_warehouse_id_setting,
        @issuelog.wwo_id_setting,
        @issuelog.issue_board,
        @issuelog.issue_board_column,
        @issuelog.issue_board_column_ordering,
        @issuelog.resp_external_user_id
    FROM issuelog 
    WHERE issuelog.id = issuelog_id;

    IF @issuelog.id IS NULL THEN
        LEAVE proc_label;
    END IF;

    -- Get issue priority information
    SET @issue_priority = NULL;

    SELECT
        issue_priority.color,
        issue_priority.name,
        issue_priority.id
    INTO @issue_priority_color,
        @issue_priority_name,
        @issue_priority
    FROM issue_priority
    WHERE issue_priority.id = @issuelog.issue_priority;

    IF @issue_priority IS NULL THEN
        LEAVE proc_label;
    END IF;

    -- Get external user information if applicable
    IF @issuelog.resp_external_user_id IS NOT NULL THEN
        SELECT 
            resp_external_user.email,
            resp_external_user.name
        INTO 
            @resp_external_user.email,
            @resp_external_user.name
        FROM public_issue.external_user AS resp_external_user
        WHERE resp_external_user.id = @issuelog.resp_external_user_id
            AND resp_external_user.passhash IS NOT NULL;
    END IF;

    -- Get responsible user information
    IF @issuelog.resp_username IS NOT NULL THEN
        SELECT
            COALESCE(users.name, @resp_external_user.name),
            COALESCE(users.email, @resp_external_user.email),
            IF(users.use_as_shipping_company = 4, 1, 0)
        INTO 
            @user_name,
            @resp_email,
            @resp_massuser
        FROM users
        WHERE users.username = @issuelog.resp_username;
    END IF;

    -- Get solving user information
    IF @issuelog.solving_resp_username IS NOT NULL THEN
        SELECT 
            users_solving.email,
            IF(users_solving.use_as_shipping_company = 4, 1, 0),
            users_solving.username,
            users_solving.username,
            users_solving.name
        INTO 
            @solving_user_email,
            @solving_massuser,
            @users_solving.username,
            @solving_username,
            @solving_user_name
        FROM users users_solving
        WHERE users_solving.username = @issuelog.solving_resp_username;
    END IF;

    IF @solving_massuser is null THEN
        SET @solving_massuser = 0;
    END IF;

    -- Get auction information if applicable
    SET @number = NULL;
    SET @txnid = NULL;

    IF @issuelog.obj_id IS NOT NULL 
        AND @issuelog.obj is not null
        AND @issuelog.obj = CAST('auction' AS CHAR CHARACTER SET utf8) THEN
        
        SELECT 
            auction.txnid,
            auction.auction_number,
            IF(auction.auction_number, auction.auction_number, @issuelog.obj_id),
            IF(auction.txnid, auction.txnid, '')
        INTO 
            @auction.txnid,
            @auction.auction_number,
            @number,
            @txnid
        FROM auction
        WHERE auction.id = @issuelog.obj_id;
    END IF;

    SET @number = IF(@number, @number, @issuelog.obj_id);
    SET @txnid = IF(@txnid, @txnid, '');

    -- Get RMA information if applicable
    IF @issuelog.obj_id is not null
        AND @issuelog.obj is not null
        AND @issuelog.obj = CAST("rma" AS CHAR CHARACTER SET utf8) THEN
        
        SELECT 
            rma.auction_number,
            rma.txnid
        INTO 
            @rma.auction_number,
            @rma.txnid
        FROM rma
        WHERE rma.rma_id = @issuelog.obj_id;
    END IF;

    -- Get log information about when the issue was added
    SELECT 
        tl.ID,
        tl.Updated,
        tl.username_id
    INTO 
        @tl.ID,
        @added_time,
        @tl.username_id
    FROM total_log_issuelog tl
    WHERE tl.field_name_id = get_field___name('id')
        AND tl.TableID = @issuelog.id 
    ORDER BY tl.ID DESC
    LIMIT 1;

    -- Get log information about when the status was changed
    SELECT 
        tl_st.Updated,
        tl_st.username_id
    INTO 
        @change_time,
        @tl_st.username_id
    FROM total_log_issuelog tl_st
    WHERE tl_st.field_name_id = get_field___name('status')
        AND tl_st.TableID = @issuelog.id 
    ORDER BY tl_st.ID ASC
    LIMIT 1;

    -- Get all dates when status was set to "open"
    SELECT
        GROUP_CONCAT(DISTINCT tl_st_open.Updated ORDER BY tl_st_open.id)
    INTO @open_dates
    FROM total_log_issuelog tl_st_open
    WHERE tl_st_open.field_name_id = get_field___name('status')
        AND tl_st_open.TableID = @issuelog.id
        AND tl_st_open.`New_value` = "open";

    -- Get all dates when status was not "open"
    SELECT
        GROUP_CONCAT(DISTINCT tl_st_not_open.Updated ORDER BY tl_st_not_open.id)
    INTO @not_open_dates
    FROM total_log_issuelog tl_st_not_open
    WHERE tl_st_not_open.field_name_id = get_field___name('status')
        AND tl_st_not_open.TableID = @issuelog.id
        AND tl_st_not_open.New_value <> "open";

    -- Get information about the person who added the issue
    IF @tl.username_id IS NOT NULL THEN
        SELECT 
            users_tl.name,
            users_tl.username,
            users_tl.deleted,
            users_tl.deleted,
            users_tl.use_as_shipping_company,
            users_tl.username
        INTO 
            @added_person,
            @users_tl.username,
            @users_tl.deleted,
            @added_person_deleted,
            @users_tl.use_as_shipping_company,
            @added_person_username
        FROM users users_tl
        WHERE users_tl.id = @tl.username_id;
    END IF;

    -- Get department information for the person who added the issue
    IF @users_tl.username IS NOT NULL THEN
        SELECT 
            added_person_employee.department_id
        INTO 
            @added_person_employee.department_id
        FROM employee AS added_person_employee
        WHERE added_person_employee.username = @users_tl.username;
    END IF;

    -- Get department details for the person who added the issue
    IF @added_person_employee.department_id IS NOT NULL THEN
        SELECT 
            added_person_department.direct_super_username,
            added_person_department.main_super_username,
            added_person_department.name
        INTO 
            @added_person_department.direct_super_username,
            @added_person_department.main_super_username,
            @added_person_department_name
        FROM emp_department AS added_person_department
        WHERE added_person_department.id = @added_person_employee.department_id;
    END IF;

    -- Get direct supervisor information
    IF @added_person_department.direct_super_username IS NOT NULL THEN
        SELECT 
            added_user_direct.deleted,
            added_user_direct.username,
            added_user_direct.use_as_shipping_company
        INTO 
            @added_user_direct.deleted,
            @added_user_direct.username,
            @added_user_direct.use_as_shipping_company
        FROM users added_user_direct
        WHERE added_user_direct.username = @added_person_department.direct_super_username;
    END IF;

    -- Get main supervisor information
    IF @added_person_department.main_super_username IS NOT NULL THEN
        SELECT 
            added_user_main.deleted,
            added_user_main.username,
            added_user_main.use_as_shipping_company
        INTO 
            @added_user_main.deleted,
            @added_user_main.username,
            @added_user_main.use_as_shipping_company
        FROM users added_user_main
        WHERE added_user_main.username = @added_person_department.main_super_username;
    END IF;

    -- Get department information for the solving user
    IF @users_solving.username IS NOT NULL THEN
        SELECT 
            solving_employee.department_id
        INTO 
            @solving_employee.department_id
        FROM employee AS solving_employee
        WHERE solving_employee.username = @users_solving.username;
    END IF;

    -- Get department supervisors for the solving user
    IF @solving_employee.department_id IS NOT NULL THEN
        SELECT 
            solving_department.direct_super_username,
            solving_department.main_super_username
        INTO 
            @solv_direct,
            @solv_main
        FROM emp_department AS solving_department
        WHERE solving_department.id = @solving_employee.department_id;
    END IF;

    -- Check if current user can change solving user
    SELECT count(super_dep.id)
    INTO @allow_change_solving
    FROM emp_department super_dep
    WHERE (super_dep.main_super_username = curent_user
        OR super_dep.direct_super_username = curent_user) 
        AND super_dep.deleted = 0;
    
    -- Get who changed the status
    IF @tl_st.username_id IS NOT NULL THEN
        SELECT 
            users_tl_st.name
        INTO 
            @change_by
        FROM users users_tl_st
        WHERE users_tl_st.id = @tl_st.username_id;
    END IF;

    -- Get issue type information
    SELECT GROUP_CONCAT(
            DISTINCT
            CONCAT(issuelog_type.type_id, ':', is_type.inactive, ':', is_type.color, ':', is_type.name)
            ORDER BY issuelog_type.id
            SEPARATOR '#@#@#'
        ),
        MAX(is_type.status_by_solving),
        MAX(is_type.solving_changeable_by_any_user),
        MAX(is_type.ping_changeable_by_any_user),
        MAX(is_type.status_changeable_by_any_user),
        MAX(is_type.priority_changeable_by_any_user),
        MAX(is_type.due_date_changeable_by_any_user),
        MAX(is_type.restricted_access),
        MAX(is_type.subject_in_url),
        MAX(is_type.generate_label)
    INTO 
        @issue_type,
        @status_by_solving,
        @solving_changeable_by_any_user,
        @ping_changeable_by_any_user,
        @status_changeable_by_any_user,
        @priority_changeable_by_any_user,
        @due_date_changeable_by_any_user,
        @restricted_access_automatic,
        @subject_in_url,
        @generate_label
    FROM issuelog_type
    JOIN issue_type is_type 
        ON issuelog_type.type_id = is_type.id
    WHERE issuelog_type.issuelog_id = @issuelog.id;

    SET @restricted_access = IF(@restricted_access_automatic + @issuelog.restricted_access, 1, 0);
    SET @subject_in_url = IF(@subject_in_url, 1, 0);
    SET @generate_label = IF(@generate_label, 1, 0);

    -- Get issue board information
    SELECT
        COALESCE(issue_board.name),
        COALESCE(issue_board_column.name),
        GROUP_CONCAT(
            DISTINCT
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
        )
    INTO 
        @issue_board_name,
        @issue_board_column_name,
        @issuelog_boards
    FROM issuelog_x_board
    LEFT JOIN issue_board
        ON issue_board.id = issuelog_x_board.issue_board_id
    LEFT JOIN issue_board_column
        ON issue_board_column.id = issuelog_x_board.issue_board_column_id
    WHERE issuelog_x_board.issuelog_id = @issuelog.id 
        AND issuelog_x_board.issue_board_id IS NOT NULL;

    SET @issue_board_name = COALESCE(@issue_board_name, '');
    SET @issue_board_column_name = COALESCE(@issue_board_column_name, '');

    -- Get supplier information if applicable
    IF @issuelog.obj_id IS NOT NULL 
        AND @issuelog.obj is not null
        AND @issuelog.obj = CAST('supplier' AS CHAR CHARACTER SET utf8) THEN
        
        SELECT 
            sup.name
        INTO 
            @sup.name
        FROM op_company sup
        WHERE sup.id = @issuelog.obj_id;
    END IF;

    -- Get department information for the issue
    SELECT 
        GROUP_CONCAT(DISTINCT CONCAT(isd.department_id, '$#$#$', empd.name, '$#$#$', empd.deleted) SEPARATOR ', '),
        GROUP_CONCAT(DISTINCT empd.name SEPARATOR ', ')
    INTO 
        @department_id,
        @department_name
    FROM issuelog_dep isd
    JOIN emp_department empd
        ON empd.id = isd.department_id
    WHERE isd.issuelog_id = @issuelog.id;

    -- Get autoship import log information if applicable
    IF @issuelog.obj_id IS NOT NULL THEN
        SELECT 
            ail.name
        INTO 
            @ail.name
        FROM autoship_import_log ail
        WHERE ail.id = @issuelog.obj_id;
    END IF;

    -- Get ping days information
    SET @ipd.days = NULL;

    SELECT 
        ipd.user_id,
        ipd.days
    INTO 
        @userid,
        @ipd.days
    FROM issue_ping_days ipd
    WHERE ipd.obj = 'issuelog'
        AND ipd.obj_id = @issuelog.id;

    SET @ping_days = COALESCE(@ipd.days, 21);

    -- Get all access users for the issue
    SELECT GROUP_CONCAT(DISTINCT ila.username) as all_access_user
    INTO @all_access_user
    FROM issuelog_access ila
    WHERE ila.issuelog_id = @issuelog.id;

    -- Get ping list for the issue
    SELECT GROUP_CONCAT(DISTINCT ipu.username)
    INTO @ping_list
    FROM issue_ping_user ipu
    WHERE ipu.obj_id = @issuelog.id 
        AND ipu.obj = 'issuelog';

    -- Check if issue is favorite for current user
    SELECT IFNULL(issuelog_marked_x_user.favorite, 0)
    INTO @favorite
    FROM issuelog_marked_x_user
    WHERE issuelog_marked_x_user.issuelog_id = @issuelog.id
        AND issuelog_marked_x_user.username = curent_user;

    SET @favorite = IFNULL(@favorite, 0);

    -- Get information about who last changed restricted access
    SET @users.name_tmp = NULL;
    SET @external_user.name_ = NULL;
    SET @tl_rest.username_id = NULL;

    SELECT 
        tl_rest.username_id,
        tl_rest.Updated
    INTO 
        @tl_rest.username_id,
        @tl_rest.Updated
    FROM total_log_issuelog AS tl_rest
    WHERE tl_rest.field_name_id = get_field___name('restricted_access')
        AND tl_rest.TableID = @issuelog.id 
    ORDER BY tl_rest.ID DESC
    LIMIT 1;

    IF @tl_rest.username_id IS NOT NULL THEN
        IF @tl_rest.username_id > 0 THEN
            SELECT users.name
            INTO @users.name_tmp
            FROM users
            WHERE users.id = @tl_rest.username_id;
        ELSEIF @tl_rest.username_id < 0 THEN
            SELECT external_user.name
            INTO @external_user.name_
            FROM public_issue.external_user AS external_user
            WHERE external_user.id = ABS(@tl_rest.username_id);
        END IF;

        SET @last_restricted_updated = CONCAT(COALESCE(@users.name_tmp, @external_user.name_, ''), ' on ', @tl_rest.Updated);
    END IF;

    -- Get information about who last changed recurring status
    SET @users.name_ = NULL;
    SET @external_user.name_ = NULL;
    SET @tl_tmp.username_id = NULL;

    SELECT 
        tl_tmp.username_id,
        tl_tmp.Updated
    INTO 
        @tl_tmp.username_id,
        @tl_tmp.Updated
    FROM total_log_issuelog AS tl_tmp
    WHERE tl_tmp.field_name_id = get_field___name('recurring')
        AND tl_tmp.TableID = @issuelog.id
    ORDER BY tl_tmp.ID DESC
    LIMIT 1;

    IF @tl_tmp.username_id IS NOT NULL THEN
        IF @tl_tmp.username_id > 0 THEN
            SELECT users.name
            INTO @users.name_
            FROM users
            WHERE users.id = @tl_tmp.username_id;
        ELSEIF @tl_tmp.username_id < 0 THEN
            SELECT external_user.name
            INTO @external_user.name_
            FROM public_issue.external_user AS external_user
            WHERE external_user.id = ABS(@tl_tmp.username_id);
        END IF;
    END IF;

    SET @last_recurring_info = CONCAT(@tl_tmp.Updated, ',', COALESCE(@users.name_, @external_user.name_, ''));

    -- Get information about who last changed issue priority
    SET @users.name_ = NULL;
    SET @external_user.name_ = NULL;
    SET @tl_tmp.username_id = NULL;

    SELECT 
        tl_tmp.Updated,
        tl_tmp.username_id
    INTO 
        @tl_tmp.Updated,
        @tl_tmp.username_id
    FROM total_log_issuelog AS tl_tmp
    WHERE tl_tmp.field_name_id = get_field___name('issue_priority')
        AND tl_tmp.TableID = @issuelog.id
    ORDER BY tl_tmp.ID DESC
    LIMIT 1;

    IF @tl_tmp.username_id IS NOT NULL THEN
        IF @tl_tmp.username_id > 0 THEN
            SELECT users.name
            INTO @users.name_
            FROM users
            WHERE users.id = @tl_tmp.username_id;
        ELSEIF @tl_tmp.username_id < 0 THEN
            SELECT external_user.name
            INTO @external_user.name_
            FROM public_issue.external_user AS external_user
            WHERE external_user.id = ABS(@tl_tmp.username_id);
        END IF;

        SET @issue_priority_changed_by = CONCAT(COALESCE(@users.name_, @external_user.name_, ''), ' on ', @tl_tmp.Updated);
    END IF;

    -- Get information about who last changed due date
    SET @users.name_ = NULL;
    SET @external_user.name_ = NULL;
    SET @tl_tmp.username_id = NULL;

    SELECT 
        tl_tmp.username_id,
        tl_tmp.Updated
    INTO 
        @tl_tmp.username_id,
        @tl_tmp.Updated
    FROM total_log_issuelog AS tl_tmp
    WHERE tl_tmp.field_name_id = get_field___name('due_date')
        AND tl_tmp.TableID = @issuelog.id
    ORDER BY tl_tmp.ID DESC
    LIMIT 1;

    IF @tl_tmp.username_id IS NOT NULL THEN
        IF @tl_tmp.username_id > 0 THEN
            SELECT users.name
            INTO @users.name_
            FROM users
            WHERE users.id = @tl_tmp.username_id;
        ELSEIF @tl_tmp.username_id < 0 THEN
            SELECT external_user.name
            INTO @external_user.name_
            FROM public_issue.external_user AS external_user
            WHERE external_user.id = ABS(@tl_tmp.username_id);
        END IF;

        SET @due_date_changed_by = CONCAT(COALESCE(@users.name_, @external_user.name_, ''), ' on ', @tl_tmp.Updated);
    END IF;

    -- Get information about who last changed warehouse settings
    SET @tl_tmp.Updated = NULL;
    SET @tl_tmp.username_id = NULL;
    SET @u.name_ = NULL;

    SELECT 
        tl_tmp.Updated,
        tl_tmp.username_id
    INTO 
        @tl_tmp.Updated,
        @tl_tmp.username_id
    FROM total_log_issuelog tl_tmp
    WHERE tl_tmp.field_name_id IN (get_field___name('from_warehouse_id_setting'), get_field___name('to_warehouse_id_setting'), get_field___name('wwo_id_setting'))
        AND tl_tmp.TableID = @issuelog.id
    ORDER BY tl_tmp.Updated DESC
    LIMIT 1;

    IF @tl_tmp.username_id IS NOT NULL THEN
        SELECT u.name
        INTO @u.name_
        FROM users u
        WHERE u.id = @tl_tmp.username_id;

        SET @last_add_wwo_setting_change = CONCAT(@tl_tmp.Updated, ',', IFNULL(@u.name_, ''));
    END IF;

    -- Get information about last board change
    SET @tl.id_ = NULL;
    SET @last_board_change = NULL;

    SELECT GROUP_CONCAT(
            CONCAT(IFNULL(ib.issue_board_id, 0), '%$%$%', COALESCE(users.name, external_user.name, ''), ' on ', tl.Updated) 
            ORDER BY tl.id DESC
            SEPARATOR '#$#$#'
        )
    INTO @last_board_change
    FROM total_log_issuelog_x_board tl
    LEFT JOIN users
        ON users.id = tl.username_id
        AND tl.username_id > 0
    LEFT JOIN public_issue.external_user AS external_user
        ON external_user.id = ABS(tl.username_id)
        AND tl.username_id < 0
    JOIN issuelog_x_board ib ON ib.id = tl.TableID
    WHERE tl.id in ( 
        SELECT MAX(tli.id)
        FROM issuelog_x_board ib
        JOIN total_log_issuelog_x_board tli 
            ON tli.field_name_id = get_field___name('issue_board_id')
            AND tli.TableID = ib.id
        WHERE ib.issuelog_id = @issuelog.id
        GROUP BY tli.TableID
    );

    -- Get information about last board column change
    SET @tl.id_ = NULL;
    SET @last_board_column_change = NULL;

    SELECT GROUP_CONCAT(
            CONCAT(IFNULL(ib.issue_board_id, 0), '%$%$%', COALESCE(users.name, external_user.name, ''), ' on ', tl.Updated) 
            ORDER BY tl.id DESC
            SEPARATOR '#$#$#'
        )
    INTO @last_board_column_change
    FROM total_log_issuelog_x_board tl
    LEFT JOIN users
        ON users.id = tl.username_id
        AND tl.username_id > 0
    LEFT JOIN public_issue.external_user AS external_user
        ON external_user.id = ABS(tl.username_id)
        AND tl.username_id < 0
    JOIN issuelog_x_board ib 
        ON ib.id = tl.TableID
    WHERE tl.id in ( 
        SELECT MAX(tli.id)
        FROM issuelog_x_board ib
        JOIN total_log_issuelog_x_board tli 
            ON tli.TableID = ib.id
        WHERE tli.field_name_id = get_field___name('issue_board_column_id')
            AND ib.issuelog_id = @issuelog.id
        GROUP BY tli.TableID
    );

    -- Get information about who last changed issue type
    SELECT 
        tl_tmp.Updated,
        tl_tmp.username_id
    INTO 
        @tl_tmp.Updated_,
        @tl_tmp.username_id_
    FROM total_log AS tl_tmp
    WHERE tl_tmp.table_name_id = get_table___name('issuelog_type')
        AND tl_tmp.field_name_id = get_field___name('issuelog_id')
        AND tl_tmp.TableID in (SELECT issuelog_type.id FROM issuelog_type WHERE issuelog_type.issuelog_id = @issuelog.id)
        AND tl_tmp.New_value = @issuelog.id
        AND tl_tmp.Old_value IS NULL
    ORDER BY tl_tmp.ID DESC
    LIMIT 1;

    IF @tl_tmp.username_id_ IS NOT NULL THEN
        IF @tl_tmp.username_id_ > 0 THEN
            SELECT users.name
            INTO @users.name_
            FROM users
            WHERE users.id = @tl_tmp.username_id_;
        ELSEIF @tl_tmp.username_id_ < 0 THEN
            SELECT external_user.name
            INTO @external_user.name_
            FROM public_issue.external_user AS external_user
            WHERE external_user.id = ABS(@tl_tmp.username_id_);
        END IF;
    END IF;

    SET @last_issue_type_change = CONCAT(COALESCE(@users.name_, @external_user.name_, ''), ' on ', @tl_tmp.Updated_);

    -- Get information about who last changed access list
    SET @tl_tmp.Updated = NULL;
    SET @tl_tmp.username_id = NULL;

    SELECT 
        tl_tmp.Updated,
        tl_tmp.username_id,
        CONCAT(users.name, ' on ', tl_tmp.Updated)
    INTO 
        @tl_tmp.Updated,
        @tl_tmp.username_id,
        @last_access_list_change
    FROM total_log tl_tmp
    JOIN users 
        ON users.id = tl_tmp.username_id
    WHERE tl_tmp.TableID IN (SELECT issuelog_access.id FROM issuelog_access WHERE issuelog_access.issuelog_id = @issuelog.id)
        AND tl_tmp.table_name_id = get_table___name('issuelog_access')
        AND tl_tmp.field_name_id = get_field___name('username')
    ORDER BY tl_tmp.id DESC
    LIMIT 1;

    -- Determine who should be shown as the added person if they are deleted
    SET @added_person_if_deleted = IF(@users_tl.deleted, 
        IF(@added_user_direct.deleted, 
            IF(@added_user_main.deleted, 
                @users_tl.username, 
                @added_user_main.username
            ), 
            @added_user_direct.username
        ),
        @users_tl.username
    );

    -- Determine if the added person is a mass user
    SET @added_person_massuser = IF(
        IF(@users_tl.deleted,
            IF(@added_user_direct.deleted, 
                IF(@added_user_main.deleted, 
                    @users_tl.use_as_shipping_company,
                    @added_user_main.use_as_shipping_company
                ),
                @added_user_direct.use_as_shipping_company
            ),
            @users_tl.use_as_shipping_company
        ) = 4, 
        1,
        0
    );

    -- Get checkpoint information
    SELECT COUNT(*)
    INTO @checkpoints_total
    FROM issue_checkpoint ic 
    WHERE ic.issuelog_id = @issuelog.id;

    SELECT COUNT(*) 
    INTO @checkpoints_done
    FROM issue_checkpoint ic 
    WHERE ic.issuelog_id = @issuelog.id 
        AND ic.done = 1;

    -- Check if close notification exists for current user
    SELECT COUNT(*)
    INTO @close_notif
    FROM close_notif
    WHERE close_notif.obj = 'issuelog'
        AND close_notif.obj_id = @issuelog.id
        AND close_notif.username = curent_user;

    -- Determine where the issue came from based on object type
    SET @where_did = NULL;

    IF @issuelog.obj IS NOT NULL THEN
        IF @issuelog.obj = CAST('auction' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Auftrag: ';
        ELSEIF @issuelog.obj = CAST('shop_catalogue' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Shop catalogue: ';
        ELSEIF @issuelog.obj = CAST('shipping_plan' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Shipping plan: ';
        ELSEIF @issuelog.obj = CAST('sa' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'SA: ';
        ELSEIF @issuelog.obj = CAST('offer' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Offer: ';
        ELSEIF @issuelog.obj = CAST('article' AS CHAR CHARACTER SET utf8) THEN
            SET @company_id_tmp = NULL;

            SELECT company_id 
            INTO @company_id_tmp
            FROM article 
            WHERE article_id = @issuelog.obj_id 
                AND admin_id = 0;

            IF @company_id_tmp IS NOT NULL THEN
                SELECT GROUP_CONCAT(employee.username)
                INTO @where_did
                FROM employee
                WHERE employee.id IN (
                    SELECT op_company_emp.emp_id
                    FROM op_company_emp
                    WHERE op_company_emp.company_id = @company_id_tmp
                    AND op_company_emp.type = 'purch'
                )
                AND employee.inactive = 0
                ORDER BY employee.name, employee.name2;

                IF @where_did IS NOT NULL THEN
                    SET @where_did = CONCAT('Article: |', @where_did);
                END IF;
            END IF;
        ELSEIF @issuelog.obj = CAST('supplier' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Supplier: ';
        ELSEIF @issuelog.obj = CAST('rma' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Ticket: ';
        ELSEIF @issuelog.obj = CAST('op_order' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'OP Order: ';
        ELSEIF @issuelog.obj = CAST('route' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Route: ';
        ELSEIF @issuelog.obj = CAST('rating' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Rating: ';
        ELSEIF @issuelog.obj = CAST('insurance' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Insurance: ';
        ELSEIF @issuelog.obj = CAST('shippingInvoiceResults' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Shipping invoice: ';
        ELSEIF @issuelog.obj = CAST('monitoredShippingPrices' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Monitored shipping price: ';
        ELSEIF @issuelog.obj = CAST('wwo' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'WWO: ';
        ELSEIF @issuelog.obj = CAST('car' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Car: ';
        ELSEIF @issuelog.obj = CAST('fork_lift' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Forklift: ';
        ELSEIF @issuelog.obj = CAST('op_order_container' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Container: ';
        ELSEIF @issuelog.obj = CAST('palette' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Palette: ';
        ELSEIF @issuelog.obj = CAST('shippingMethod' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Shipping Method: ';
        ELSEIF @issuelog.obj = CAST('shipping_cost' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Shipping price: ';
        ELSEIF @issuelog.obj = CAST('newsletter' AS CHAR CHARACTER SET utf8) THEN
            SET @where_did = 'Newsletter: ';
        END IF;
    END IF;

    -- Generate URL based on object type
    SET @url = NULL;

    IF @issuelog.obj IS NOT NULL THEN
        IF @issuelog.obj = CAST('auction' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'auction.php?number=',
                @auction.auction_number,
                '&txnid=',
                @auction.txnid
            );
        ELSEIF @issuelog.obj = CAST('shop_catalogue' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'shop_cat.php?id=0&shop_id=1&cat_id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('shipping_plan' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'shipping_plan.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('sa' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'react/condensed/condensed_sa/',
                @issuelog.obj_id,
                '/'
            );
        ELSEIF @issuelog.obj = CAST('offer' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'offer.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('article' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'article.php?original_article_id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('supplier' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'op_suppliers.php?company_id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('rma' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'rma.php?rma_id=',
                @issuelog.obj_id,
                '&number=',
                @rma.auction_number,
                '&txnid=',
                @rma.txnid
            );
        ELSEIF @issuelog.obj = CAST('op_order' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'op_order.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('route' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'route.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('rating' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'rating_case.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('insurance' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'insurance.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('shippingInvoiceResults' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'react/shipping_pages/invoice_settings/result/',
                @issuelog.obj_id,
                '/'
            );
        ELSEIF @issuelog.obj = CAST('monitoredShippingPrices' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'react/logs/shipping_price_monitor/',
                @issuelog.obj_id,
                '/'
            );
        ELSEIF @issuelog.obj = CAST('wwo' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'ware2ware_order.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('car' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'car.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('fork_lift' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'fork_lift.php?id=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('op_order_container' AS CHAR CHARACTER SET utf8) THEN
            IF @issuelog.obj_id IS NOT NULL THEN
                SELECT order_id 
                INTO @order_id_
                FROM op_order_container ooc 
                WHERE ooc.id = @issuelog.obj_id;

                IF @order_id_ IS NOT NULL THEN
                    SET @url = CONCAT(
                        'op_order.php?id=',
                        @order_id_,
                        '&filter_container_id=', 
                        @issuelog.obj_id
                    );
                END IF;
            END IF;
        ELSEIF @issuelog.obj = CAST('palette' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'parcel_barcodes.php?filter[code]=',
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('shippingMethod' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'method.php?id=', 
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('shipping_cost' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'shipping_price.php?id=', 
                @issuelog.obj_id
            );
        ELSEIF @issuelog.obj = CAST('newsletter' AS CHAR CHARACTER SET utf8) THEN
            SET @url = CONCAT(
                'news_email.php?id=', 
                @issuelog.obj_id
            );
        END IF;
    END IF;

    -- Generate URL text based on object type
    IF @issuelog.obj IS NOT NULL THEN
        IF @issuelog.obj = CAST('supplier' AS CHAR CHARACTER SET utf8) THEN
            SET @url_text = @sup.name;
        ELSEIF @issuelog.obj = CAST('car' AS CHAR CHARACTER SET utf8) THEN
            SELECT cars.name 
            INTO @cars.name_
            FROM cars 
            WHERE cars.id = @issuelog.obj_id;

            IF @cars.name_ IS NOT NULL THEN
                SET @url_text = CONCAT(
                    'Car: ', 
                    @issuelog.obj_id, 
                    ' (', 
                    @cars.name_,
                    ')'
                );
            END IF;
        ELSEIF @issuelog.obj = CAST('fork_lift' AS CHAR CHARACTER SET utf8) THEN
            SELECT fork_lift.model 
            INTO @fork_lift.model_
            FROM fork_lift 
            WHERE fork_lift.id = @issuelog.obj_id;

            IF @fork_lift.model_ IS NOT NULL THEN
                SET @url_text = CONCAT(
                    'Forklift: ',
                    @issuelog.obj_id, 
                    ' (',
                    @fork_lift.model_,
                    ')'
                );
            END IF;
        ELSEIF @issuelog.obj = CAST('shippingInvoiceResults' AS CHAR CHARACTER SET utf8) THEN
            SET @url_text = CONCAT(
                'Shipping invoice ',
                @ail.name
            );
        ELSEIF @issuelog.obj = CAST('op_order_container' AS CHAR CHARACTER SET utf8) THEN
            SELECT ooc.order_id 
            INTO @ooc.order_id_
            FROM op_order_container ooc 
            WHERE ooc.id = @issuelog.obj_id;

            IF @ooc.order_id_ IS NOT NULL THEN
                SET @url_text = CONCAT(
                    'OP Order: ',
                    @ooc.order_id_
                );
            END IF;
        ELSEIF @issuelog.obj = CAST('palette' AS CHAR CHARACTER SET utf8) THEN
            SELECT vparcel_barcode.parcel
            INTO @vparcel_barcode.parcel_
            FROM vparcel_barcode
            WHERE vparcel_barcode.id = @issuelog.obj_id;

            IF @vparcel_barcode.parcel_ IS NOT NULL THEN
                SET @url_text = CONCAT(
                    'Palette: ', 
                    @vparcel_barcode.parcel_
                );
            END IF;
        ELSEIF @issuelog.obj = CAST('shippingMethod' AS CHAR CHARACTER SET utf8) THEN
            SELECT shipping_method.company_name 
            INTO @shipping_method.company_name_
            FROM shipping_method 
            WHERE shipping_method.shipping_method_id = @issuelog.obj_id;

            IF @shipping_method.company_name_ IS NOT NULL THEN
                SET @url_text = CONCAT(
                    'Shipping method: ', 
                    @shipping_method.company_name_
                );
            END IF;
        ELSEIF @issuelog.obj = CAST('shipping_cost' AS CHAR CHARACTER SET utf8) THEN
            SET @url_text = CONCAT(
                'Shipping price: ', 
                @issuelog.obj_id
            );
        END IF;
    END IF;
END$$

DELIMITER ;