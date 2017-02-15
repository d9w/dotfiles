function conda_activate -d 'Activate julia conda environment'
  # condabin will be the path to the bin directory
  # in the specified conda environment
  set condabin ~/.julia/v0.4/Conda/deps/usr/bin/
  # check whether the condabin directory actually exists and
  # exit the function with an error status if it does not
  if not test -d $condabin
    echo 'Environment not found.'
  end

  # save the current path
  set -xg DEFAULT_PATH $PATH

  # put the condabin directory at the front of the PATH
  set -xg PATH $condabin $PATH

  # this is an undocumented environmental variable that influences
  # how conda behaves when you don't specify an environment for it.
  # https://github.com/conda/conda/issues/473
  set -xg CONDA_DEFAULT_ENV "root"

  # set up the prompt so it has the env name in it
  functions -e _old_fish_prompt
  functions -c fish_prompt _old_fish_prompt

  function fish_prompt
    set -l old_status $status
    if test -n ""
        printf '%s%s' "" (set_color normal)
    else
        printf '%s(%s) ' (set_color normal) (echo "$CONDA_DEFAULT_ENV")
    end

    # Restore the original $status
    echo "exit $old_status" | source
    _old_fish_prompt
  end

  # flag for whether a conda environment has been set
  set -xg __CONDA_ENV_ACTIVE 'true'

  function deactivate -d 'Deactivate a conda environment'
    if set -q __CONDA_ENV_ACTIVE
      # set PATH back to its default before activating the conda env
      set -xg PATH $DEFAULT_PATH
      set -e DEFAULT_PATH

      # unset this so that conda behaves according to its default behavior
      set -e CONDA_DEFAULT_ENV

      # reset to the original prompt
      set -l fish_function_path
      functions -e fish_prompt
      functions -c _old_fish_prompt fish_prompt
      functions -e _old_fish_prompt
      set -e __CONDA_ENV_ACTIVE
    end
  end
end