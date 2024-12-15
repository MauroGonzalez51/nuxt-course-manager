#!/bin/bash

project_name="nuxt-course-manager"
supabase_dir="$HOME/Downloads/apps/supabase/docker"
work_dir="$HOME/dev/web/$project_name"

if [[ ! -d "$work_dir" ]]; then
    echo "directory $work_dir does not exists"
    exit 1
fi

cd "$supabase_dir" || exit

docker compose down

sudo systemctl start postgresql.service

cd "$work_dir" || exit