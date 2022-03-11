# pbrain-failover

***All modifications*** are to be performed in ***LuCi*** under the ***Network*** tab.

---
### Interfaces

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

Now return to the main *Network* tab and verify the changes were pushed.
 * Look for `eth0.44` under the **LANB** informative icon
![ifaces-updated](/img/pbrain-interfaces-updated.png)


---
### Switch


