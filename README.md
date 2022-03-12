# pbrain-failover

***All modifications*** are to be performed in ***LuCi*** under the ***Network*** tab.

## Hardware: Ports
```mermaid
graph LR
    %% Public Internet
    pub((Public<br>Internet))

    %% Devices
    n00{Brainbox}
    n01>pBrain]

    %%[WAN2: (mid|p)brain LTE-Backup]
    pub -- << LTE >> --- n01
    n01 == WAN >> WAN2 === n00

    %%[WAN1: Primary]
    pub == >> WAN1 === n00
    %%{WAN3: ISP-Backup]
    pub == >> WAN2 === n00
```

## LuCi: Interfaces

Navigate to *Network -> Interfaces* and inspect the **LANB** interface
 * You should see `eth0.1` under the informative icon as pictured.
![ifaces-init](/img/pbrain-interfaces-initial.png)

---
***Only*** for **LANB** navigate to: *EDIT -> Physical Settings*
 * You screen should now look like this
![ifaces-physical-init](/img/pbrain-interfaces-physical-initial.png)

---
Change the *Interface* from `eth0.1` to `eth0.44` then click **SAVE & APPLY**
 * You should now see the following
![ifaces-physical-updated](/img/pbrain-interfaces-physical-updated.png)

---
Now return to the main *Network* tab to verify the changes were pushed successfully.
 * Look for `eth0.44` under the **LANB** informative icon
![ifaces-updated](/img/pbrain-interfaces-updated.png)


## LuCi: Switch Config

Now navigate to *Network -> Switch*
 * Under the *VLAN ID* column you should only see an entry for **1** and **2** like the following
![switch-init](/img/pbrain-switch-initial.png)

---
Click **ADD** then set the **VLAN ID** column to **44**.
 * All *VLAN ID 44* fields must be set as ***tagged***
 * Then click **SAVE & APPLY**.
 * You should see the following when you're finished. 
![switch-updated](/img/pbrain-switch-updated.png)


## MWAN3 Testing

An ethernet link to the switch is required for *hotplug* testing.


#### Valid `mwan3 status` output
```txt
Interface status:
 interface WAN1 is online 22h:52m:50s, uptime 22h:53m:30s and tracking is active
 interface WAN2 is offline and tracking is down
 interface WAN3 is online 22h:52m:48s, uptime 22h:53m:30s and tracking is active
 interface LTE is online 00h:1m:12s, uptime 22h:53m:30s and tracking is active

Current ipv4 policies:
BAL_WANs:
 WAN3 (50%)
 WAN1 (50%)
BAL_WANs_FO_LTE:
 WAN3 (50%)
 WAN1 (50%)

Directly connected ipv4 networks:
*[omit]*

Active ipv4 user rules:
 327K   18M - BAL_WANs_FO_LTE  all  --  *      *       0.0.0.0/0            0.0.0.0/0   
```

---
### Installing (Linux|WSL)
```bash 
# Create a $USER/bin directory 
[ -d ~/bin ] || mkdir ~/bin 

# Navigate to your $USER/bin dir
cd ~/bin

# Clone this repository into your local machine ~/bin dir
git clone 'https://github.com/wirediq-dev-bc/pbrain-failover.git'
```

### Helpers

**CMDS=/pbrain-failover/bin/**

`$CMDS/mwan-stat.sh [--help]`
  * Continously run `mwan3 status` on a remote/LAN host.

`$CMDS/mwan-ping.sh [--help]`
  * Continously `ping` on *eth0*, *eth2* and *eth1.44* interfaces.

### Test Procedure
```bash
# Navigate to the pbrain-failover/bin dir
cd ~/bin/pbrain-failover/bin

# Run test suite on host
./mwan-ping root@10.1.10.1
./mwan-stats root@10.1.10.1
```
