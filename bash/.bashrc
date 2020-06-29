alias sshs="ssh ackermch@supply.mit.edu"
alias skim="open -a skim"
set editing-mode vi
set keymap vi-command
#export PATH="${PATH}:/usr/local/stata15"


# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.bash"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

PATH="/Applications/MATLAB_R2019a.app/bin:${PATH}"
export PATH

PATH="$PATH:/usr/local/stata15/"
export PATH

export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

# gitlatex path:
export PATH=~/build:$PATH








































































# added by Anaconda3 2019.07 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/ChristophersMac/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/ChristophersMac/anaconda3/etc/profile.d/conda.sh" ]; then
	. "/Users/ChristophersMac/anaconda3/etc/profile.d/conda.sh"
	CONDA_CHANGEPS1=false conda activate base
    else
	\export PATH="/Users/ChristophersMac/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<








export PATH="/usr/local/opt/mysql-client/bin:$PATH"
