# 004 — Microsoft Defender Antivirus Policy

**Platform:** Microsoft Intune  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Configure Microsoft Defender Antivirus through Microsoft Intune to provide centrally managed malware protection for pilot Windows devices.

## 💼 Business Purpose

Provide pilot endpoints with centrally managed malware protection, real-time threat detection, cloud-based analysis, and network protection while preventing local users from weakening organization-managed security controls.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Endpoint security → Antivirus`

## ⚙️ Actions Performed

### 1. Create the Microsoft Defender Antivirus Policy

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Endpoint security → Antivirus`

3. Select **Create Policy**.
4. Configure:
   - **Platform:** Windows
   - **Profile:** Microsoft Defender Antivirus
5. Enter the policy name:

   `WIN-SEC-Pilot-Defender`

6. Continue to the configuration settings.
7. Configure the Microsoft Defender Antivirus settings.
8. Review the configuration.

**Configuration Details**

- **Archive scanning:** Enabled
- **Behavior monitoring:** Enabled
- **Cloud-delivered protection:** Enabled
- **Email scanning:** Enabled
- **Removable-drive scanning:** Enabled
- **Downloaded files and attachments scanning:** Enabled
- **Real-time monitoring:** Enabled
- **Network-file scanning:** Enabled
- **Script scanning:** Enabled
- **Signature checks before scans:** Enabled
- **Cloud block level:** High
- **Low CPU priority:** Enabled
- **Network Protection:** Block mode
- **Potentially unwanted application protection:** Enabled
- **Real-time scanning:** All files
- **Safe sample submission:** Automatic
- **Local administrator policy merge:** Disabled
- **On-access protection:** Enabled
- **Exclusions:** None configured

### 2. Assign the Policy

1. Continue to the **Assignments** page.
2. Select the security group:

   `SG-PILOT-Intune-Devices`

3. Review the included group.
4. Review the deployment scope.
5. Save and create the policy.

**Assignment Details**

- **Assignment Type:** Included group
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Policy Name:** `WIN-SEC-Pilot-Defender`

### 3. Sync the Pilot Device

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Devices → Windows → Windows devices`

2. Open `LAB-WIN-01`.
3. Select **Sync**.
4. Confirm the synchronization request.
5. Allow the endpoint time to complete a new Intune check-in.

**Sync Details**

- Device synchronization initiated from Intune
- Defender policy targeted to the pilot endpoint
- Device check-in completed without reported errors

## ✅ Validation

### 1. Sync Validation

1. In the **Microsoft Intune Admin Center**, open `LAB-WIN-01`.
2. Review the device check-in information.
3. Confirm the latest check-in time updated after the synchronization request.
4. Confirm no synchronization errors were reported.

**Sync Results**

- Device synchronized successfully
- Device check-in time updated
- No synchronization errors detected

### 2. Endpoint Readiness Validation

1. Open the virtualization or endpoint-management platform hosting `LAB-WIN-01`.
2. Confirm the validation device is powered on.
3. Confirm the device has network connectivity.
4. Confirm the device can communicate with Microsoft cloud services.
5. Open the virtual-machine console or connect through Remote Desktop.
6. Sign in using the lab user account.

**Environment Details**

- **Virtualization Platform:** Proxmox VE
- **Validation Device:** `LAB-WIN-01`
- **Operating System:** Windows 11
- **Access Method:** Remote Desktop or Proxmox console

### 3. Windows Security UI Validation

1. On `LAB-WIN-01`, open **Windows Security**.
2. Navigate to:

   `Virus & threat protection`

3. Review the current protection status.
4. Select **Quick scan**.
5. Allow the scan to complete.
6. Open **Manage settings** under Virus & threat protection settings.
7. Confirm real-time protection is enabled.
8. Confirm the protection settings are centrally managed.
9. Attempt to disable real-time protection and confirm the local user cannot override the organization-managed setting.

**Windows Security Results**

- No current threats detected
- Virus and threat protection active
- No action required
- Quick scan completed successfully
- **Real-time protection:** On
- **Protection engine:** Microsoft Defender Antivirus
- Administrator-managed settings message displayed
- Local user unable to disable centrally managed real-time protection

### 4. Intune Report Validation

1. Return to the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Endpoint security → Antivirus`

3. Open `WIN-SEC-Pilot-Defender`.
4. Review the device assignment and endpoint-status reports.
5. Regenerate or refresh the applicable report.
6. Locate `LAB-WIN-01`.
7. Confirm the policy deployment status.
8. Review the endpoint health and malware-detection results.

**Report Results**

- Policy created successfully
- Policy assignment successful
- **Unhealthy endpoints:** 0
- **Active malware detections:** 0
- **Policy conflicts:** 0
- **Deployment errors:** 0

### 5. PowerShell Protection Status Validation

1. On `LAB-WIN-01`, select **Start**.
2. Search for **Windows PowerShell**.
3. Select **Run as administrator**.
4. Approve the User Account Control prompt.
5. Run:

```powershell
Get-MpComputerStatus
```

6. Review the Microsoft Defender Antivirus service, protection, signature, scan, and restart status.

**PowerShell Results**

- `AMServiceEnabled`: **True**
- `AntivirusEnabled`: **True**
- `AntispywareEnabled`: **True**
- `BehaviorMonitorEnabled`: **True**
- `IoavProtectionEnabled`: **True**
- `NISEnabled`: **True**
- `OnAccessProtectionEnabled`: **True**
- `RealTimeProtectionEnabled`: **True**
- `DefenderSignaturesOutOfDate`: **False**
- `QuickScanOverdue`: **False**
- `RebootRequired`: **False**

### 6. PowerShell Focused Status Validation

1. In the same elevated **Windows PowerShell** session, run:

```powershell
Get-MpComputerStatus |
Select-Object AMServiceEnabled,
              AntivirusEnabled,
              AntispywareEnabled,
              BehaviorMonitorEnabled,
              IoavProtectionEnabled,
              NISEnabled,
              OnAccessProtectionEnabled,
              RealTimeProtectionEnabled,
              DefenderSignaturesOutOfDate,
              QuickScanOverdue,
              RebootRequired
```

2. Confirm the required Microsoft Defender Antivirus services and protection components are enabled.
3. Confirm security intelligence is current.
4. Confirm the quick scan is not overdue.
5. Confirm no restart is required.

**Focused Status Results**

- Antivirus and antispyware protection enabled
- Behavior monitoring enabled
- Network inspection enabled
- On-access protection enabled
- Real-time protection enabled
- Security intelligence current
- Quick scan not overdue
- No restart required

### 7. PowerShell Policy Preference Validation

1. In the same elevated **Windows PowerShell** session, run:

```powershell
Get-MpPreference |
Select-Object PUAProtection,
              EnableNetworkProtection,
              CloudBlockLevel,
              DisableRealtimeMonitoring,
              DisableBehaviorMonitoring,
              DisableScriptScanning,
              DisableArchiveScanning,
              DisableIOAVProtection,
              DisableScanningNetworkFiles,
              DisableRemovableDriveScanning,
              DisableLocalAdminMerge
```

2. Review the returned policy values.
3. Confirm the Microsoft Intune configuration is reflected on the endpoint.

**Policy Preference Results**

- Potentially unwanted application protection enabled
- Network Protection configured in Block mode
- Cloud block level configured as High
- Real-time monitoring enabled
- Behavior monitoring enabled
- Script scanning enabled
- Archive scanning enabled
- Downloaded file and attachment scanning enabled
- Network-file scanning enabled
- Removable-drive scanning enabled
- Local administrator policy merge disabled

## 🧾 Final Result

The Microsoft Defender Antivirus policy was successfully deployed to the pilot security group and validated on `LAB-WIN-01`. Windows Security, Intune reporting, and Windows PowerShell verification confirmed that real-time, cloud-delivered, behavior-based, network, and on-access protections were active and centrally enforced. No unhealthy endpoints, active malware detections, policy conflicts, or deployment errors were reported.
