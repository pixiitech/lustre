# Lustre

Lustre is a Ruby on Rails/Vue.js single-page application for fetching
rare and antique coin prices and descriptions from PCGS's API.

<img src="https://github.com/pixiitech/lustre/blob/main/lib/assets/readme/lustre-screenshot-1.png" width="600" height="450" alt="Price Guide Categories" />
<img src="https://github.com/pixiitech/lustre/blob/main/lib/assets/readme/lustre-screenshot-2.png" width="600" height="450" alt="Price Guide Result" />

Live demo is at https://lustre.pixiitech.net

* System dependencies
    - Ruby 3.3.1
    - bun package manager
    - Node v22
    - Vite 5.2.13 (server for Vue)
    - PCGS API key (one can be obtained by creating a free account on pcgs.com)
    - SQLite 3.46
    - Install foreman (not mandatory, but allows running both processes in the same window)

* Configuration
    - Clone repo using github ssh
    - Create config/application.yml with:
      `PCGS_URL: https://api.pcgs.com/publicapi/coindetail/`
      `PCGS_API_TOKEN: _api token from pcgs.com_`

* Database creation
    - rake db:create

* Database initialization
    - rake db:migrate
    - rake db:seed (this will populate known PCGS data from lib/assets/coins)

* Running app
    - foreman start -f Procfile.dev
    - or run individual commands in Procfile.dev
