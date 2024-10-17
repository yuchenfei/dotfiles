function conda --wraps conda
    echo 'Initializing conda...'
    functions --erase conda
    eval ~/miniconda3/bin/conda shell.fish hook | source

    if not functions -q conda
        echo 'Failed to initialize conda.' >&2
        return 1
    end

    conda $argv
end
