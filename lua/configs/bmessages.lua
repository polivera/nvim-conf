require("bmessages").setup({
	-- Time in milliseconds between each update of the messages buffer.
	timer_interval = 1000,
	-- Default split type for the messages buffer ('vsplit' or 'split').
	split_type = "vsplit",
	-- Default split direction for the messages buffer ('topleft' or 'botright').
	split_direction = nil,
	-- Size of the vertical split when opening the messages buffer.
	split_size_vsplit = nil,
	-- Size of the horizontal split when opening the messages buffer.
	split_size_split = nil,
	-- Automatically scroll to the latest message in the buffer.
	autoscroll = true,
	-- Use a timer to auto-update the messages buffer. When this is disabled,
	-- the buffer will not update, but the buffer becomes modifiable.
	use_timer = true,
	-- Name of the messages buffer.
	buffer_name = "bmessages_buffer",
	-- Don't add user commands for `Bmessages`, `Bmessagesvs`, and `Bmessagessp`.
	disable_create_user_commands = false,
	-- Don't focus the bmessages window after opening.
	keep_focus = false,
})
