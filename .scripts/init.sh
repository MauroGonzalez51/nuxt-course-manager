#!/bin/bash

project_name="nuxt-course-manager"
supabase_dir="$HOME/Downloads/apps/supabase/docker"
work_dir="$HOME/dev/web/$project_name"

if [[ ! -d "$work_dir" ]]; then
    echo "directory $work_dir does not exists"
    exit 1
fi

if systemctl is-active --quiet postgresql.service; then
    sudo systemctl stop postgresql.service
fi

cd "$supabase_dir" || exit

export POSTGRES_DB="${project_name}_db"

# This will be used only in dev
export ANON_KEY="xA7fTGmCDSTWKmT1d2fJyNOTMojpBp4R+tvng4duKCU="

docker compose up -d

cd "$work_dir" || exit