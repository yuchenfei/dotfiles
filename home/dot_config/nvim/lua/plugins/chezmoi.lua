-- chezmoi_root_file only works when source_dir_path is empty.
-- https://github.com/alker0/chezmoi.vim/blob/abf37336437867cbd99ce2f8849b717415391cc3/filetype.vim#L43
return {
  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      -- vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmo/home"
    end,
  },
}
