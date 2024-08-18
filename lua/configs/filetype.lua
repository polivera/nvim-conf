vim.filetype.add({
	pattern = {
		[".*.tmux.conf"] = "tmux",
		[".*/git/config"] = "gitconfig",
		[".*/.xapenv"] = "sh",
		[".*/.xapenv.leave"] = "sh",
	},
})
