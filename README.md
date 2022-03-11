# pbrain-failover

***All modifications*** are to be performed in ***LuCi*** under the ***Network*** tab.

## Interfaces Config

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


## Switch Config

Now navigate to *Network -> Switch*
 * Under the *VLAN ID* column you should only see an entry for **1** and **2** like the following
![switch-init](/img/pbrain-switch-initial.png)

---
Click **ADD** then set the *VLAN ID* column to **44**. All other **VLAN ID 44** fields must be set as ***tagged***
 * You should see the following when you're finished. Then click **SAVE & APPLY**
![switch-updated](/img/pbrain-switch-updated.png)

## MWAN3 Testing

The files provided under `pbrain-failover/bin` are written to poll the target host's mwan functionality

You will need a direct ethernet connection to the target host as you will be *hotplug* testing

```bash 
# Navigate to your user/bin directory
cd ~/bin

# Clone this repository onto your local machine
git clone 'https://github.com/wirediq-dev-bc/pbrain-failover.git'

# Navigate to the pbrain-failover/bin directory
cd ~/bin/pbrain-failover/bin

# Run these tests after reconfiguring the pbrain
./mwan-stats root@192.168.1.1
./mwan-ping root@192.168.1.1
```


