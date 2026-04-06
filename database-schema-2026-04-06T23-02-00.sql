# Paperclip Database Export Report
Generated: 2026-04-06T23:02:00.065Z

## Tables (63 total)

### account
- **Rows**: 0
- **Columns**: 13
- **Fields**:
  - `id` (text)
  - `account_id` (text)
  - `provider_id` (text)
  - `user_id` (text)
  - `access_token` (text)
  - `refresh_token` (text)
  - `id_token` (text)
  - `access_token_expires_at` (timestamp with time zone)
  - `refresh_token_expires_at` (timestamp with time zone)
  - `scope` (text)
  - `password` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### activity_log
- **Rows**: 22
- **Columns**: 11
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `actor_type` (text)
  - `actor_id` (text)
  - `action` (text)
  - `entity_type` (text)
  - `entity_id` (text)
  - `agent_id` (uuid)
  - `details` (jsonb)
  - `created_at` (timestamp with time zone)
  - `run_id` (uuid)

### agent_api_keys
- **Rows**: 1
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `agent_id` (uuid)
  - `company_id` (uuid)
  - `name` (text)
  - `key_hash` (text)
  - `last_used_at` (timestamp with time zone)
  - `revoked_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)

### agent_config_revisions
- **Rows**: 0
- **Columns**: 11
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `agent_id` (uuid)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `source` (text)
  - `rolled_back_from_revision_id` (uuid)
  - `changed_keys` (jsonb)
  - `before_config` (jsonb)
  - `after_config` (jsonb)
  - `created_at` (timestamp with time zone)

### agent_runtime_state
- **Rows**: 2
- **Columns**: 14
- **Fields**:
  - `agent_id` (uuid)
  - `company_id` (uuid)
  - `adapter_type` (text)
  - `session_id` (text)
  - `state_json` (jsonb)
  - `last_run_id` (uuid)
  - `last_run_status` (text)
  - `total_input_tokens` (bigint)
  - `total_output_tokens` (bigint)
  - `total_cached_input_tokens` (bigint)
  - `total_cost_cents` (bigint)
  - `last_error` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### agent_task_sessions
- **Rows**: 1
- **Columns**: 11
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `agent_id` (uuid)
  - `adapter_type` (text)
  - `task_key` (text)
  - `session_params_json` (jsonb)
  - `session_display_id` (text)
  - `last_run_id` (uuid)
  - `last_error` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### agent_wakeup_requests
- **Rows**: 8
- **Columns**: 19
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `agent_id` (uuid)
  - `source` (text)
  - `trigger_detail` (text)
  - `reason` (text)
  - `payload` (jsonb)
  - `status` (text)
  - `coalesced_count` (integer)
  - `requested_by_actor_type` (text)
  - `requested_by_actor_id` (text)
  - `idempotency_key` (text)
  - `run_id` (uuid)
  - `requested_at` (timestamp with time zone)
  - `claimed_at` (timestamp with time zone)
  - `finished_at` (timestamp with time zone)
  - `error` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### agents
- **Rows**: 2
- **Columns**: 21
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `name` (text)
  - `role` (text)
  - `title` (text)
  - `status` (text)
  - `reports_to` (uuid)
  - `capabilities` (text)
  - `adapter_type` (text)
  - `adapter_config` (jsonb)
  - `budget_monthly_cents` (integer)
  - `spent_monthly_cents` (integer)
  - `last_heartbeat_at` (timestamp with time zone)
  - `metadata` (jsonb)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `runtime_config` (jsonb)
  - `permissions` (jsonb)
  - `icon` (text)
  - `pause_reason` (text)
  - `paused_at` (timestamp with time zone)

### approval_comments
- **Rows**: 0
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `approval_id` (uuid)
  - `author_agent_id` (uuid)
  - `author_user_id` (text)
  - `body` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### approvals
- **Rows**: 0
- **Columns**: 12
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `type` (text)
  - `requested_by_agent_id` (uuid)
  - `requested_by_user_id` (text)
  - `status` (text)
  - `payload` (jsonb)
  - `decision_note` (text)
  - `decided_by_user_id` (text)
  - `decided_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### assets
- **Rows**: 0
- **Columns**: 12
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `provider` (text)
  - `object_key` (text)
  - `content_type` (text)
  - `byte_size` (integer)
  - `sha256` (text)
  - `original_filename` (text)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### board_api_keys
- **Rows**: 0
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `user_id` (text)
  - `name` (text)
  - `key_hash` (text)
  - `last_used_at` (timestamp with time zone)
  - `revoked_at` (timestamp with time zone)
  - `expires_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)

### budget_incidents
- **Rows**: 0
- **Columns**: 17
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `policy_id` (uuid)
  - `scope_type` (text)
  - `scope_id` (uuid)
  - `metric` (text)
  - `window_kind` (text)
  - `window_start` (timestamp with time zone)
  - `window_end` (timestamp with time zone)
  - `threshold_type` (text)
  - `amount_limit` (integer)
  - `amount_observed` (integer)
  - `status` (text)
  - `approval_id` (uuid)
  - `resolved_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### budget_policies
- **Rows**: 0
- **Columns**: 15
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `scope_type` (text)
  - `scope_id` (uuid)
  - `metric` (text)
  - `window_kind` (text)
  - `amount` (integer)
  - `warn_percent` (integer)
  - `hard_stop_enabled` (boolean)
  - `notify_enabled` (boolean)
  - `is_active` (boolean)
  - `created_by_user_id` (text)
  - `updated_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### cli_auth_challenges
- **Rows**: 0
- **Columns**: 15
- **Fields**:
  - `id` (uuid)
  - `secret_hash` (text)
  - `command` (text)
  - `client_name` (text)
  - `requested_access` (text)
  - `requested_company_id` (uuid)
  - `pending_key_hash` (text)
  - `pending_key_name` (text)
  - `approved_by_user_id` (text)
  - `board_api_key_id` (uuid)
  - `approved_at` (timestamp with time zone)
  - `cancelled_at` (timestamp with time zone)
  - `expires_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### companies
- **Rows**: 1
- **Columns**: 14
- **Fields**:
  - `id` (uuid)
  - `name` (text)
  - `description` (text)
  - `status` (text)
  - `budget_monthly_cents` (integer)
  - `spent_monthly_cents` (integer)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `issue_prefix` (text)
  - `issue_counter` (integer)
  - `require_board_approval_for_new_agents` (boolean)
  - `brand_color` (text)
  - `pause_reason` (text)
  - `paused_at` (timestamp with time zone)

### company_logos
- **Rows**: 0
- **Columns**: 5
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `asset_id` (uuid)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### company_memberships
- **Rows**: 3
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `principal_type` (text)
  - `principal_id` (text)
  - `status` (text)
  - `membership_role` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### company_secret_versions
- **Rows**: 0
- **Columns**: 9
- **Fields**:
  - `id` (uuid)
  - `secret_id` (uuid)
  - `version` (integer)
  - `material` (jsonb)
  - `value_sha256` (text)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `revoked_at` (timestamp with time zone)

### company_secrets
- **Rows**: 0
- **Columns**: 11
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `name` (text)
  - `provider` (text)
  - `external_ref` (text)
  - `latest_version` (integer)
  - `description` (text)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### company_skills
- **Rows**: 4
- **Columns**: 16
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `key` (text)
  - `slug` (text)
  - `name` (text)
  - `description` (text)
  - `markdown` (text)
  - `source_type` (text)
  - `source_locator` (text)
  - `source_ref` (text)
  - `trust_level` (text)
  - `compatibility` (text)
  - `file_inventory` (jsonb)
  - `metadata` (jsonb)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### cost_events
- **Rows**: 5
- **Columns**: 18
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `agent_id` (uuid)
  - `issue_id` (uuid)
  - `project_id` (uuid)
  - `goal_id` (uuid)
  - `billing_code` (text)
  - `provider` (text)
  - `model` (text)
  - `input_tokens` (integer)
  - `output_tokens` (integer)
  - `cost_cents` (integer)
  - `occurred_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `heartbeat_run_id` (uuid)
  - `biller` (text)
  - `billing_type` (text)
  - `cached_input_tokens` (integer)

### document_revisions
- **Rows**: 0
- **Columns**: 9
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `document_id` (uuid)
  - `revision_number` (integer)
  - `body` (text)
  - `change_summary` (text)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `created_at` (timestamp with time zone)

### documents
- **Rows**: 0
- **Columns**: 13
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `title` (text)
  - `format` (text)
  - `latest_body` (text)
  - `latest_revision_id` (uuid)
  - `latest_revision_number` (integer)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `updated_by_agent_id` (uuid)
  - `updated_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### execution_workspaces
- **Rows**: 2
- **Columns**: 24
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `project_id` (uuid)
  - `project_workspace_id` (uuid)
  - `source_issue_id` (uuid)
  - `mode` (text)
  - `strategy_type` (text)
  - `name` (text)
  - `status` (text)
  - `cwd` (text)
  - `repo_url` (text)
  - `base_ref` (text)
  - `branch_name` (text)
  - `provider_type` (text)
  - `provider_ref` (text)
  - `derived_from_execution_workspace_id` (uuid)
  - `last_used_at` (timestamp with time zone)
  - `opened_at` (timestamp with time zone)
  - `closed_at` (timestamp with time zone)
  - `cleanup_eligible_at` (timestamp with time zone)
  - `cleanup_reason` (text)
  - `metadata` (jsonb)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### finance_events
- **Rows**: 0
- **Columns**: 27
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `agent_id` (uuid)
  - `issue_id` (uuid)
  - `project_id` (uuid)
  - `goal_id` (uuid)
  - `heartbeat_run_id` (uuid)
  - `cost_event_id` (uuid)
  - `billing_code` (text)
  - `description` (text)
  - `event_kind` (text)
  - `direction` (text)
  - `biller` (text)
  - `provider` (text)
  - `execution_adapter_type` (text)
  - `pricing_tier` (text)
  - `region` (text)
  - `model` (text)
  - `quantity` (integer)
  - `unit` (text)
  - `amount_cents` (integer)
  - `currency` (text)
  - `estimated` (boolean)
  - `external_invoice_id` (text)
  - `metadata_json` (jsonb)
  - `occurred_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)

### goals
- **Rows**: 1
- **Columns**: 10
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `title` (text)
  - `description` (text)
  - `level` (text)
  - `status` (text)
  - `parent_id` (uuid)
  - `owner_agent_id` (uuid)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### heartbeat_run_events
- **Rows**: 19
- **Columns**: 12
- **Fields**:
  - `id` (bigint)
  - `company_id` (uuid)
  - `run_id` (uuid)
  - `agent_id` (uuid)
  - `seq` (integer)
  - `event_type` (text)
  - `stream` (text)
  - `level` (text)
  - `color` (text)
  - `message` (text)
  - `payload` (jsonb)
  - `created_at` (timestamp with time zone)

### heartbeat_runs
- **Rows**: 6
- **Columns**: 32
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `agent_id` (uuid)
  - `invocation_source` (text)
  - `status` (text)
  - `started_at` (timestamp with time zone)
  - `finished_at` (timestamp with time zone)
  - `error` (text)
  - `external_run_id` (text)
  - `context_snapshot` (jsonb)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `trigger_detail` (text)
  - `wakeup_request_id` (uuid)
  - `exit_code` (integer)
  - `signal` (text)
  - `usage_json` (jsonb)
  - `result_json` (jsonb)
  - `session_id_before` (text)
  - `session_id_after` (text)
  - `log_store` (text)
  - `log_ref` (text)
  - `log_bytes` (bigint)
  - `log_sha256` (text)
  - `log_compressed` (boolean)
  - `stdout_excerpt` (text)
  - `stderr_excerpt` (text)
  - `error_code` (text)
  - `process_pid` (integer)
  - `process_started_at` (timestamp with time zone)
  - `retry_of_run_id` (uuid)
  - `process_loss_retry_count` (integer)

### instance_settings
- **Rows**: 1
- **Columns**: 6
- **Fields**:
  - `id` (uuid)
  - `singleton_key` (text)
  - `experimental` (jsonb)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `general` (jsonb)

### instance_user_roles
- **Rows**: 1
- **Columns**: 5
- **Fields**:
  - `id` (uuid)
  - `user_id` (text)
  - `role` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### invites
- **Rows**: 2
- **Columns**: 12
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `invite_type` (text)
  - `token_hash` (text)
  - `allowed_join_types` (text)
  - `defaults_payload` (jsonb)
  - `expires_at` (timestamp with time zone)
  - `invited_by_user_id` (text)
  - `revoked_at` (timestamp with time zone)
  - `accepted_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### issue_approvals
- **Rows**: 0
- **Columns**: 6
- **Fields**:
  - `company_id` (uuid)
  - `issue_id` (uuid)
  - `approval_id` (uuid)
  - `linked_by_agent_id` (uuid)
  - `linked_by_user_id` (text)
  - `created_at` (timestamp with time zone)

### issue_attachments
- **Rows**: 0
- **Columns**: 7
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `issue_id` (uuid)
  - `asset_id` (uuid)
  - `issue_comment_id` (uuid)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### issue_comments
- **Rows**: 2
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `issue_id` (uuid)
  - `author_agent_id` (uuid)
  - `author_user_id` (text)
  - `body` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### issue_documents
- **Rows**: 0
- **Columns**: 7
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `issue_id` (uuid)
  - `document_id` (uuid)
  - `key` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### issue_labels
- **Rows**: 0
- **Columns**: 4
- **Fields**:
  - `issue_id` (uuid)
  - `label_id` (uuid)
  - `company_id` (uuid)
  - `created_at` (timestamp with time zone)

### issue_read_states
- **Rows**: 1
- **Columns**: 7
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `issue_id` (uuid)
  - `user_id` (text)
  - `last_read_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### issue_work_products
- **Rows**: 0
- **Columns**: 20
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `project_id` (uuid)
  - `issue_id` (uuid)
  - `execution_workspace_id` (uuid)
  - `runtime_service_id` (uuid)
  - `type` (text)
  - `provider` (text)
  - `external_id` (text)
  - `title` (text)
  - `url` (text)
  - `status` (text)
  - `review_state` (text)
  - `is_primary` (boolean)
  - `health_status` (text)
  - `summary` (text)
  - `metadata` (jsonb)
  - `created_by_run_id` (uuid)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### issues
- **Rows**: 1
- **Columns**: 35
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `project_id` (uuid)
  - `goal_id` (uuid)
  - `parent_id` (uuid)
  - `title` (text)
  - `description` (text)
  - `status` (text)
  - `priority` (text)
  - `assignee_agent_id` (uuid)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `request_depth` (integer)
  - `billing_code` (text)
  - `started_at` (timestamp with time zone)
  - `completed_at` (timestamp with time zone)
  - `cancelled_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `issue_number` (integer)
  - `identifier` (text)
  - `hidden_at` (timestamp with time zone)
  - `checkout_run_id` (uuid)
  - `execution_run_id` (uuid)
  - `execution_agent_name_key` (text)
  - `execution_locked_at` (timestamp with time zone)
  - `assignee_user_id` (text)
  - `assignee_adapter_overrides` (jsonb)
  - `execution_workspace_settings` (jsonb)
  - `project_workspace_id` (uuid)
  - `execution_workspace_id` (uuid)
  - `execution_workspace_preference` (text)
  - `origin_kind` (text)
  - `origin_id` (text)
  - `origin_run_id` (text)

### join_requests
- **Rows**: 1
- **Columns**: 22
- **Fields**:
  - `id` (uuid)
  - `invite_id` (uuid)
  - `company_id` (uuid)
  - `request_type` (text)
  - `status` (text)
  - `request_ip` (text)
  - `requesting_user_id` (text)
  - `request_email_snapshot` (text)
  - `agent_name` (text)
  - `adapter_type` (text)
  - `capabilities` (text)
  - `agent_defaults_payload` (jsonb)
  - `created_agent_id` (uuid)
  - `approved_by_user_id` (text)
  - `approved_at` (timestamp with time zone)
  - `rejected_by_user_id` (text)
  - `rejected_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `claim_secret_hash` (text)
  - `claim_secret_expires_at` (timestamp with time zone)
  - `claim_secret_consumed_at` (timestamp with time zone)

### labels
- **Rows**: 0
- **Columns**: 6
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `name` (text)
  - `color` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### plugin_company_settings
- **Rows**: 0
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `plugin_id` (uuid)
  - `settings_json` (jsonb)
  - `last_error` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `enabled` (boolean)

### plugin_config
- **Rows**: 0
- **Columns**: 6
- **Fields**:
  - `id` (uuid)
  - `plugin_id` (uuid)
  - `config_json` (jsonb)
  - `last_error` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### plugin_entities
- **Rows**: 0
- **Columns**: 11
- **Fields**:
  - `id` (uuid)
  - `plugin_id` (uuid)
  - `entity_type` (text)
  - `scope_kind` (text)
  - `scope_id` (text)
  - `external_id` (text)
  - `title` (text)
  - `status` (text)
  - `data` (jsonb)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### plugin_job_runs
- **Rows**: 0
- **Columns**: 11
- **Fields**:
  - `id` (uuid)
  - `job_id` (uuid)
  - `plugin_id` (uuid)
  - `trigger` (text)
  - `status` (text)
  - `duration_ms` (integer)
  - `error` (text)
  - `logs` (jsonb)
  - `started_at` (timestamp with time zone)
  - `finished_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)

### plugin_jobs
- **Rows**: 0
- **Columns**: 9
- **Fields**:
  - `id` (uuid)
  - `plugin_id` (uuid)
  - `job_key` (text)
  - `schedule` (text)
  - `status` (text)
  - `last_run_at` (timestamp with time zone)
  - `next_run_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### plugin_logs
- **Rows**: 0
- **Columns**: 6
- **Fields**:
  - `id` (uuid)
  - `plugin_id` (uuid)
  - `level` (text)
  - `message` (text)
  - `meta` (jsonb)
  - `created_at` (timestamp with time zone)

### plugin_state
- **Rows**: 0
- **Columns**: 8
- **Fields**:
  - `id` (uuid)
  - `plugin_id` (uuid)
  - `scope_kind` (text)
  - `scope_id` (text)
  - `namespace` (text)
  - `state_key` (text)
  - `value_json` (jsonb)
  - `updated_at` (timestamp with time zone)

### plugin_webhook_deliveries
- **Rows**: 0
- **Columns**: 12
- **Fields**:
  - `id` (uuid)
  - `plugin_id` (uuid)
  - `webhook_key` (text)
  - `external_id` (text)
  - `status` (text)
  - `duration_ms` (integer)
  - `error` (text)
  - `payload` (jsonb)
  - `headers` (jsonb)
  - `started_at` (timestamp with time zone)
  - `finished_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)

### plugins
- **Rows**: 0
- **Columns**: 13
- **Fields**:
  - `id` (uuid)
  - `plugin_key` (text)
  - `package_name` (text)
  - `package_path` (text)
  - `version` (text)
  - `api_version` (integer)
  - `categories` (jsonb)
  - `manifest_json` (jsonb)
  - `status` (text)
  - `install_order` (integer)
  - `last_error` (text)
  - `installed_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### principal_permission_grants
- **Rows**: 2
- **Columns**: 9
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `principal_type` (text)
  - `principal_id` (text)
  - `permission_key` (text)
  - `scope` (jsonb)
  - `granted_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### project_goals
- **Rows**: 1
- **Columns**: 5
- **Fields**:
  - `project_id` (uuid)
  - `goal_id` (uuid)
  - `company_id` (uuid)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### project_workspaces
- **Rows**: 0
- **Columns**: 19
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `project_id` (uuid)
  - `name` (text)
  - `cwd` (text)
  - `repo_url` (text)
  - `repo_ref` (text)
  - `metadata` (jsonb)
  - `is_primary` (boolean)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `source_type` (text)
  - `default_ref` (text)
  - `visibility` (text)
  - `setup_command` (text)
  - `cleanup_command` (text)
  - `remote_provider` (text)
  - `remote_workspace_ref` (text)
  - `shared_workspace_key` (text)

### projects
- **Rows**: 1
- **Columns**: 15
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `goal_id` (uuid)
  - `name` (text)
  - `description` (text)
  - `status` (text)
  - `lead_agent_id` (uuid)
  - `target_date` (date)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `color` (text)
  - `archived_at` (timestamp with time zone)
  - `execution_workspace_policy` (jsonb)
  - `pause_reason` (text)
  - `paused_at` (timestamp with time zone)

### routine_runs
- **Rows**: 0
- **Columns**: 15
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `routine_id` (uuid)
  - `trigger_id` (uuid)
  - `source` (text)
  - `status` (text)
  - `triggered_at` (timestamp with time zone)
  - `idempotency_key` (text)
  - `trigger_payload` (jsonb)
  - `linked_issue_id` (uuid)
  - `coalesced_into_run_id` (uuid)
  - `failure_reason` (text)
  - `completed_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### routine_triggers
- **Rows**: 0
- **Columns**: 22
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `routine_id` (uuid)
  - `kind` (text)
  - `label` (text)
  - `enabled` (boolean)
  - `cron_expression` (text)
  - `timezone` (text)
  - `next_run_at` (timestamp with time zone)
  - `last_fired_at` (timestamp with time zone)
  - `public_id` (text)
  - `secret_id` (uuid)
  - `signing_mode` (text)
  - `replay_window_sec` (integer)
  - `last_rotated_at` (timestamp with time zone)
  - `last_result` (text)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `updated_by_agent_id` (uuid)
  - `updated_by_user_id` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### routines
- **Rows**: 0
- **Columns**: 102
- **Fields**:
  - `id` (uuid)
  - `specific_catalog` (name)
  - `specific_schema` (name)
  - `company_id` (uuid)
  - `specific_name` (name)
  - `project_id` (uuid)
  - `goal_id` (uuid)
  - `routine_catalog` (name)
  - `parent_issue_id` (uuid)
  - `routine_schema` (name)
  - `routine_name` (name)
  - `title` (text)
  - `routine_type` (character varying)
  - `description` (text)
  - `module_catalog` (name)
  - `assignee_agent_id` (uuid)
  - `priority` (text)
  - `module_schema` (name)
  - `status` (text)
  - `module_name` (name)
  - `udt_catalog` (name)
  - `concurrency_policy` (text)
  - `udt_schema` (name)
  - `catch_up_policy` (text)
  - `udt_name` (name)
  - `created_by_agent_id` (uuid)
  - `created_by_user_id` (text)
  - `data_type` (character varying)
  - `updated_by_agent_id` (uuid)
  - `character_maximum_length` (integer)
  - `updated_by_user_id` (text)
  - `character_octet_length` (integer)
  - `last_triggered_at` (timestamp with time zone)
  - `character_set_catalog` (name)
  - `character_set_schema` (name)
  - `last_enqueued_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `character_set_name` (name)
  - `updated_at` (timestamp with time zone)
  - `collation_catalog` (name)
  - `collation_schema` (name)
  - `collation_name` (name)
  - `numeric_precision` (integer)
  - `numeric_precision_radix` (integer)
  - `numeric_scale` (integer)
  - `datetime_precision` (integer)
  - `interval_type` (character varying)
  - `interval_precision` (integer)
  - `type_udt_catalog` (name)
  - `type_udt_schema` (name)
  - `type_udt_name` (name)
  - `scope_catalog` (name)
  - `scope_schema` (name)
  - `scope_name` (name)
  - `maximum_cardinality` (integer)
  - `dtd_identifier` (name)
  - `routine_body` (character varying)
  - `routine_definition` (character varying)
  - `external_name` (character varying)
  - `external_language` (character varying)
  - `parameter_style` (character varying)
  - `is_deterministic` (character varying)
  - `sql_data_access` (character varying)
  - `is_null_call` (character varying)
  - `sql_path` (character varying)
  - `schema_level_routine` (character varying)
  - `max_dynamic_result_sets` (integer)
  - `is_user_defined_cast` (character varying)
  - `is_implicitly_invocable` (character varying)
  - `security_type` (character varying)
  - `to_sql_specific_catalog` (name)
  - `to_sql_specific_schema` (name)
  - `to_sql_specific_name` (name)
  - `as_locator` (character varying)
  - `created` (timestamp with time zone)
  - `last_altered` (timestamp with time zone)
  - `new_savepoint_level` (character varying)
  - `is_udt_dependent` (character varying)
  - `result_cast_from_data_type` (character varying)
  - `result_cast_as_locator` (character varying)
  - `result_cast_char_max_length` (integer)
  - `result_cast_char_octet_length` (integer)
  - `result_cast_char_set_catalog` (name)
  - `result_cast_char_set_schema` (name)
  - `result_cast_char_set_name` (name)
  - `result_cast_collation_catalog` (name)
  - `result_cast_collation_schema` (name)
  - `result_cast_collation_name` (name)
  - `result_cast_numeric_precision` (integer)
  - `result_cast_numeric_precision_radix` (integer)
  - `result_cast_numeric_scale` (integer)
  - `result_cast_datetime_precision` (integer)
  - `result_cast_interval_type` (character varying)
  - `result_cast_interval_precision` (integer)
  - `result_cast_type_udt_catalog` (name)
  - `result_cast_type_udt_schema` (name)
  - `result_cast_type_udt_name` (name)
  - `result_cast_scope_catalog` (name)
  - `result_cast_scope_schema` (name)
  - `result_cast_scope_name` (name)
  - `result_cast_maximum_cardinality` (integer)
  - `result_cast_dtd_identifier` (name)

### session
- **Rows**: 0
- **Columns**: 8
- **Fields**:
  - `id` (text)
  - `expires_at` (timestamp with time zone)
  - `token` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `ip_address` (text)
  - `user_agent` (text)
  - `user_id` (text)

### user
- **Rows**: 1
- **Columns**: 7
- **Fields**:
  - `id` (text)
  - `name` (text)
  - `email` (text)
  - `email_verified` (boolean)
  - `image` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### verification
- **Rows**: 0
- **Columns**: 6
- **Fields**:
  - `id` (text)
  - `identifier` (text)
  - `value` (text)
  - `expires_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### workspace_operations
- **Rows**: 0
- **Columns**: 21
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `execution_workspace_id` (uuid)
  - `heartbeat_run_id` (uuid)
  - `phase` (text)
  - `command` (text)
  - `cwd` (text)
  - `status` (text)
  - `exit_code` (integer)
  - `log_store` (text)
  - `log_ref` (text)
  - `log_bytes` (bigint)
  - `log_sha256` (text)
  - `log_compressed` (boolean)
  - `stdout_excerpt` (text)
  - `stderr_excerpt` (text)
  - `metadata` (jsonb)
  - `started_at` (timestamp with time zone)
  - `finished_at` (timestamp with time zone)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)

### workspace_runtime_services
- **Rows**: 0
- **Columns**: 27
- **Fields**:
  - `id` (uuid)
  - `company_id` (uuid)
  - `project_id` (uuid)
  - `project_workspace_id` (uuid)
  - `issue_id` (uuid)
  - `scope_type` (text)
  - `scope_id` (text)
  - `service_name` (text)
  - `status` (text)
  - `lifecycle` (text)
  - `reuse_key` (text)
  - `command` (text)
  - `cwd` (text)
  - `port` (integer)
  - `url` (text)
  - `provider` (text)
  - `provider_ref` (text)
  - `owner_agent_id` (uuid)
  - `started_by_run_id` (uuid)
  - `last_used_at` (timestamp with time zone)
  - `started_at` (timestamp with time zone)
  - `stopped_at` (timestamp with time zone)
  - `stop_policy` (jsonb)
  - `health_status` (text)
  - `created_at` (timestamp with time zone)
  - `updated_at` (timestamp with time zone)
  - `execution_workspace_id` (uuid)

## Summary

- **Total tables**: 63
- **Total rows**: 91
- **Export date**: 2026-04-06T23:02:00.156Z
- **Source**: Local embedded Postgres
- **Status**: Ready for manual export

## Notes

To perform the full export and migration to Railway:

1. **Use pg_dump** (if available):
   ```bash
   PGPASSWORD=paperclip pg_dump -h localhost -p 54329 -U paperclip paperclip > backup.sql
   ```

2. **Use Railway backup tools**:
   - Upload this server's database directory to Railway
   - Or use Railway's database restore feature

3. **Document this data**:
   - Archive the database directory as backup
   - Store in safe location
