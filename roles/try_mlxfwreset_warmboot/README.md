# Try mlxfwreset Warm Boot Role

This role will attempt to perform a mlxfwreset on the DPU and the host it is installed in, then warm reboot in order for firmware upgrades or mlxconfig firmware settings to take effect without the need to power cycle the host.

The most clean way to handle changes still seems to be a cold boot or power cycle which can often be accomodated via IMPI, but in instances where that isn't possible this method can potentially be an option to try.  

This is not supported when the DPU is in secure boot mode.
