# Lustre

Lustre is a Ruby on Rails/Vue.js single-page application for fetching
rare and antique coin prices and descriptions from PCGS's API.

![Price Guide Categories](https://github.com/pixiitech/lustre/blob/main/lib/assets/readme/price-guide-screenshot-1.png "Price Guide Categories"){:height="200px" width="50px"}
![Price Guide Result](https://github.com/pixiitech/lustre/blob/main/lib/assets/readme/price-guide-screenshot-2.png "Price Guide Result"){:height="200px" width="50px"}
![Price Guide Result 2](https://github.com/pixiitech/lustre/blob/main/lib/assets/readme/price-guide-screenshot-3.png "Price Guide Result 2"){:height="200px" width="50px"}
![PCGS Holder Lookup](https://github.com/pixiitech/lustre/blob/main/lib/assets/readme/holder-lookup-screenshot-1.png "PCGS Holder Lookup"){:height="200px" width="50px"}

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
