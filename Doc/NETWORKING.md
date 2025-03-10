﻿### Hints for Networking

Choose one PC to be the Server (it may be a dusty old notebook). No need to let it mine, just let RainbowMiner start in paused mode. Select all other Rigs to act as Clients. All pool API communication will then be managed by the server: no more being blocked by the pools due to excessive use of their API

There is a Network setup build-in the configuration (press [C], then enter [N]) to help with the setup.

If you want it quicker, just run one of the following init scripts for very convenient pre-setup:
```InitServer.bat / initserver.sh``` : make this rig a server
```InitClient.bat / initclient.sh``` : make this rig a client
```InitStandalone.bat / initstandalone.sh``` : make this rig a standalone machine

Of course you may also edit the `Config\config.txt` directly.

If you change the RunMode of a rig, RainbowMiner needs to be restarted.

#### Setup as Server
- one PC takes the role as Server
- it will act as gateway to the pool APIs for all Clients 
- enable auth: choose an username and a password.
- the server will be running on the API port
- optionally provide individual config files for each client

These are the server-fields to fill in the config.txt (or use the initscripts or the build-in config)
```
  "RunMode": "server",
  "APIport": 4000,
  "APIauth": "1",
  "APIuser": "serverusername",
  "APIpassword": "serverpassword",
```

#### Setup as Client
- all other Rigs shall be clients
- if you have enable auth at the server: set the username and password.
- the RainbowMiner running on the server will tell you the machinename, ip address and port
- use either the machinename or the ip address of the server as servername
- optionally select to download config files from the server

These are the client-fields to fill in the config.txt (or use the initscripts or the build-in config)
```
  "RunMode": "client",
  "ServerName": "machinenameofserver",
  "ServerPort": 4000,
  "ServerUser": "serverusername",
  "ServerPassword": "serverpassword",
  "EnableServerConfig": "1",
  "EnableServerPools": "1",
  "ServerConfigName": "config,coins,pools",
```

If "EnableServerConfig" is set to "1" (like in the above example), the Client will download the config files defined with the list "ServerConfigName" from the Server. In the example: config.txt, coins.config.txt, pools.config.txt would be downloaded automatically.

If "EnableServerPools" is set to "1", the client will download the server's pool and balance statistics and mine to exaclty those pools (except for MiningRigRentals, which will always be handled locally)

### Note

As usual: press [U] to update, or exit RainbowMiner and start "Updater.bat" (or let RainbowMiner do the work, if you have set "EnableAutoUpdate" to 1)

If the automatic update fails for any reason, please do a manual update:
- exit RainbowMiner window
- if exit fails press ![image](https://user-images.githubusercontent.com/39437538/47248250-56272400-d409-11e8-95d1-33b78d0a8ffd.png) to close the RainbowMiner window
- now start "Updater.bat" (in RainbowMiner directory)
- now restart RainbowMiner

If the manual update failed, too, please go the hard way:
- exit RainbowMiner
- if exit fails close the RainbowMiner window
- download the actual release's zip file (name is like RainbowMinerVx.x.x.x.zip)
- extract the zip file into your RainbowMiner directory, overwriting all files
- now restart RainbowMinerRainbowMiner committed 1 hour ago### Hints for Networking

Choose one PC to be the Server (it may be a dusty old notebook). No need to let it mine, just let RainbowMiner start in paused mode. Select all other Rigs to act as Clients. All pool API communication will then be managed by the server: no more being blocked by the pools due to excessive use of their API

There is a Network setup build-in the configuration (press [C], then enter [N]) to help with the setup.

If you want it quicker, just run one of the following init scripts for very convenient pre-setup:
```InitServer.bat / initserver.sh``` : make this rig a server
```InitClient.bat / initclient.sh``` : make this rig a client
```InitStandalone.bat / initstandalone.sh``` : make this rig a standalone machine

Of course you may also edit the `Config\config.txt` directly.

If you change the RunMode of a rig, RainbowMiner needs to be restarted.

#### Setup as Server
- one PC takes the role as Server
- it will act as gateway to the pool APIs for all Clients 
- enable auth: choose an username and a password.
- the server will be running on the API port
- optionally provide individual config files for each client

These are the server-fields to fill in the config.txt (or use the initscripts or the build-in config)
```
  "RunMode": "server",
  "APIport": 4000,
  "APIauth": "1",
  "APIuser": "serverusername",
  "APIpassword": "serverpassword",
```

#### Setup as Client
- all other Rigs shall be clients
- if you have enable auth at the server: set the username and password.
- the RainbowMiner running on the server will tell you the machinename, ip address and port
- use either the machinename or the ip address of the server as servername
- optionally select to download config files from the server

These are the client-fields to fill in the config.txt (or use the initscripts or the build-in config)
```
  "RunMode": "client",
  "ServerName": "machinenameofserver",
  "ServerPort": 4000,
  "ServerUser": "serverusername",
  "ServerPassword": "serverpassword",
  "EnableServerConfig": "1",
  "EnableServerPools": "1",
  "ServerConfigName": "config,coins,pools",
```

If "EnableServerConfig" is set to "1" (like in the above example), the Client will download the config files defined with the list "ServerConfigName" from the Server. In the example: config.txt, coins.config.txt, pools.config.txt would be downloaded automatically.

If "EnableServerPools" is set to "1", the client will download the server's pool and balance statistics and mine to exaclty those pools (except for MiningRigRentals, which will always be handled locally)

### Note

As usual: press [U] to update, or exit RainbowMiner and start "Updater.bat" (or let RainbowMiner do the work, if you have set "EnableAutoUpdate" to 1)

If the automatic update fails for any reason, please do a manual update:
- exit RainbowMiner window
- if exit fails press ![image](https://user-images.githubusercontent.com/39437538/47248250-56272400-d409-11e8-95d1-33b78d0a8ffd.png) to close the RainbowMiner window
- now start "Updater.bat" (in RainbowMiner directory)
- now restart RainbowMiner

If the manual update failed, too, please go the hard way:
- exit RainbowMiner
- if exit fails close the RainbowMiner window
- download the actual release's zip file (name is like RainbowMinerVx.x.x.x.zip)
- extract the zip file into your RainbowMiner directory, overwriting all files
- now restart RainbowMiner