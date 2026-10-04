# 005 — Wi-Fi Profile Deployment

> **Context:** Personal lab

**Platform:** Microsoft Intune  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Configure and deploy a Windows Wi-Fi profile through Microsoft Intune so pilot devices can automatically connect to the designated wireless network.

## 💼 Business Purpose

Provide centrally managed wireless connectivity for Windows endpoints, reduce manual network configuration, and ensure pilot devices receive consistent Wi-Fi settings before a wider production rollout.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Devices → Windows → Configuration profiles`

## ⚙️ Actions Performed

### 1. Create the Wi-Fi Configuration Profile

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Configuration profiles`

3. Select **Create → New policy**.
4. Configure:
   - **Platform:** Windows 10 and later
   - **Profile type:** Templates
   - **Template name:** Wi-Fi
5. Select **Create**.
6. Enter the policy name and description.
7. Continue to the configuration settings.

**Configuration Details**

- **Platform:** Windows 10 and later
- **Profile Type:** Wi-Fi
- **Configuration Type:** Basic
- **Purpose:** Deploy a managed wireless network profile
- **Deployment Scope:** Pilot devices

### 2. Configure the Wireless Network Settings

1. Enter the wireless network name.
2. Configure the connection behavior.
3. Configure the wireless security settings.
4. Review the completed profile configuration.

**Wi-Fi Configuration Details**

- **SSID:** `<ADD-YOUR-SSID-NAME>`
- **Connection Name:** `<ADD-YOUR-SSID-NAME>`
- **Connect Automatically:** Yes
- **Connect When Network Is Not Broadcasting:** No
- **Preferred Network:** No
- **Metered Connection:** Unrestricted
- **Wireless Security Type:** WPA/WPA2-Personal
- **FIPS Mode:** Disabled
- **Company Proxy:** None

### 3. Assign the Policy

1. Continue to the **Assignments** page.
2. Add the following included security group:

   `SG-PILOT-Intune-Devices`

3. Review the included group.
4. Confirm that no applicability rules are configured.
5. Review the deployment scope.
6. Save and create the policy.

**Assignment Details**

- **Assignment Type:** Included group
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Deployment Method:** Pilot device group
- **Applicability Rules:** None

### 4. Sync the Pilot Device

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Devices → Windows → Windows devices`

2. Open `LAB-WIN-01`.
3. Select **Sync**.
4. Confirm the synchronization request.
5. Allow the endpoint time to complete a new Intune check-in.

**Sync Details**

- Wi-Fi profile targeted to the pilot endpoint
- Device synchronization initiated from Intune
- Device check-in completed without reported synchronization errors

## ✅ Validation

### 1. Sync Validation

1. In the **Microsoft Intune Admin Center**, open `LAB-WIN-01`.
2. Review the device check-in information.
3. Confirm the latest check-in time updated after the synchronization request.
4. Confirm no device-action errors were reported.

**Sync Results**

- Device synchronization initiated successfully
- Device completed a new Intune check-in
- No device-action errors displayed

### 2. Intune Report Validation

1. Return to the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Configuration profiles`

3. Open the Wi-Fi profile.
4. Review the device assignment status.
5. Generate or refresh the deployment report.
6. Locate `LAB-WIN-01`.
7. Review the reported deployment state, conflicts, and errors.

**Report Results**

- Wi-Fi profile created successfully
- Policy assigned to `SG-PILOT-Intune-Devices`
- Device assignment report generated
- No assignment configuration errors detected

### 3. Endpoint Readiness Validation

1. Open the virtualization or endpoint-management platform hosting `LAB-WIN-01`.
2. Confirm the validation device is powered on.
3. Confirm the device has network connectivity through its virtual Ethernet adapter.
4. Open the virtual-machine console or connect through Remote Desktop.
5. Sign in using the lab user account.
6. Confirm whether the endpoint contains a Wi-Fi network interface.

**Environment Details**

- **Virtualization Platform:** Proxmox VE
- **Validation Device:** `LAB-WIN-01`
- **Operating System:** Windows 11
- **Network Adapter Type:** Virtual Ethernet
- **Wireless Adapter Present:** No
- **Access Method:** Remote Desktop or Proxmox console

### 4. Wireless Profile Command-Line Validation

1. On `LAB-WIN-01`, open **Command Prompt**.
2. Run:

   ```cmd
   netsh wlan show profiles
   ```

3. Review the command output.
4. Confirm whether the Wireless AutoConfig service and wireless interface are available.

**Command Results**

- The command could not enumerate wireless profiles
- The Wireless AutoConfig service was not running
- No wireless network interface was available
- Full endpoint validation could not be completed on the virtual machine

### 5. Wireless Service Validation

1. On `LAB-WIN-01`, open **Windows PowerShell**.
2. Run:

   ```powershell
   Get-Service -Name WlanSvc
   ```

3. Review the service status.
4. Confirm whether Windows can start the Wireless AutoConfig service.

**Service Results**

- **Service Name:** `WlanSvc`
- **Display Name:** WLAN AutoConfig
- **Service Status:** Not running
- The service could not provide wireless functionality because the endpoint does not contain a Wi-Fi adapter

## ⚠️ Validation Limitation

`LAB-WIN-01` is a Windows virtual machine hosted on Proxmox VE and uses a virtual Ethernet adapter. The endpoint does not contain a physical or virtual Wi-Fi network interface.

Because no wireless adapter is present:

- Windows cannot process or use the deployed wireless profile
- The Wireless AutoConfig service does not provide active Wi-Fi functionality
- The profile cannot appear under Windows Wi-Fi settings
- Automatic connection to the configured SSID cannot be tested
- `netsh wlan show profiles` cannot provide a complete wireless-profile result

This behavior is expected for the current validation environment and does not by itself indicate an Intune policy-configuration issue.

## 🔭 Future Validation

Complete the following validation on a physical Windows laptop containing a supported wireless adapter.

### 1. Sync the Physical Endpoint

1. Enroll the physical Windows laptop in Microsoft Intune.
2. Add the device to:

   `SG-PILOT-Intune-Devices`

3. Initiate a device synchronization.
4. Confirm the endpoint completes a new Intune check-in.

### 2. Validate the Wi-Fi Profile in Windows

1. On the physical laptop, open **Settings**.
2. Navigate to:

   `Network & Internet → Wi-Fi → Manage known networks`

3. Confirm `<ADD-YOUR-SSID-NAME>` appears as a managed wireless network.
4. Confirm the network is configured to connect automatically.

### 3. Validate Using Command Prompt

1. Open **Command Prompt**.
2. Run:

   ```cmd
   netsh wlan show profiles
   ```

3. Confirm `<ADD-YOUR-SSID-NAME>` appears in the wireless profile list.
4. Run:

   ```cmd
   netsh wlan show interfaces
   ```

5. Confirm the wireless adapter is present and operational.

### 4. Validate Wireless Connectivity

1. Place the physical endpoint within range of the configured wireless network.
2. Confirm the endpoint automatically attempts to connect.
3. Confirm the device receives a valid IP address.
4. Confirm the device can reach the default gateway.
5. Confirm internet or authorized network access is available.
6. Review Intune reporting for the physical endpoint.

**Expected Future Results**

- `<ADD-YOUR-SSID-NAME>` appears under managed wireless networks
- The Wi-Fi profile appears in `netsh wlan show profiles`
- The wireless interface appears in `netsh wlan show interfaces`
- The device automatically connects when the SSID is available
- The endpoint receives valid network configuration
- Intune reports the profile as successfully applied

## 🧾 Final Result

The Wi-Fi profile was successfully created in Microsoft Intune and assigned to `SG-PILOT-Intune-Devices`. Device synchronization and Intune assignment reporting were completed without configuration errors.

Full endpoint validation could not be completed because `LAB-WIN-01` is a Proxmox-hosted virtual machine with only a virtual Ethernet adapter and no Wi-Fi interface. The environmental limitation was documented, and the remaining validation steps were defined for completion on a physical Windows laptop with supported wireless hardware.
