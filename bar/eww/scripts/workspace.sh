#!/bin/sh

niri msg -j workspaces | jq -c '[.[] | {idx, is_active, active_window_id}] | sort_by(.idx)'

# niri_workspace_monitor() {
#     local workspaces=$(niri msg -j workspaces | jq -c 'sort_by(.idx)')
    
#     niri msg -j event-stream | jq -c "
#         if .WorkspaceActivated then 
#             $workspaces
#         else 
#             empty 
#         end
#     " --argjson WORKSPACES "$workspaces"
# }

# # Вызов
# niri_workspace_monitor