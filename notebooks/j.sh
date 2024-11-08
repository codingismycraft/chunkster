# Remove old servers that might be running.
rm -r /home/vagrant/.local/share/jupyter/runtime/*

# Start jupyter without authentication (only for local runs).
jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password=''

