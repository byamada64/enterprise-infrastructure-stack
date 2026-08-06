# 002 — Windows Update Ring Policy

**Platform:** Microsoft Intune  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Configure a Windows Update Ring so pilot devices receive Windows updates through a controlled deployment policy managed by Microsoft Intune.

## 💼 Business Purpose

Deploy Windows updates in a controlled pilot environment before wider rollout, reducing operational risk while ensuring devices remain secure and compliant.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Devices → Windows → Update rings for Windows 10 and later`

## ⚙️ Actions Performed

### 1. Create the Windows Update Ring

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Update rings for Windows 10 and later`

3. Select **Create policy**.
4. Configure the Windows Update Ring settings.
5. Review the configuration.
6. Create the policy.

**Configuration Details**

- **Microsoft product updates:** Allow
- **Windows driver updates:** Allow
- **Quality update deferral:** 0 days
- **Feature update deferral:** 0 days
- **Automatic update behavior:** Auto install at maintenance time
- **Active hours:** 8:00 AM – 5:00 PM

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

### 3. Sync the Pilot Device

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Devices → Windows → Windows devices`

2. Open `LAB-WIN-01`.
3. Select **Sync**.
4. Confirm the synchronization request.
5. Allow the endpoint time to complete a new Intune check-in.

**Sync Details**

- Windows Update Ring targeted to the pilot endpoint
- Device synchronization initiated from Intune
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

### 3. Windows UI Validation

1. On `LAB-WIN-01`, open **Settings**.
2. Navigate to:

   `Windows Update`

3. Select **Check for updates**.
4. Review the update policy status.
5. Confirm the active hours match the configured policy.
6. Confirm Quality and Feature update settings are applied.

**Windows UI Results**

- Windows Update policy applied
- Active Hours: **8:00 AM – 5:00 PM**
- Quality updates managed
- Feature updates managed
- No update policy errors displayed

### 4. Intune Report Validation

1. Return to the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Update rings for Windows 10 and later`

3. Open the Windows Update Ring policy.
4. Review the device assignment report.
5. Regenerate or refresh the report.
6. Locate `LAB-WIN-01`.
7. Confirm the deployment status.

**Report Results**

- Policy assignment successful
- Intune Assignment Status: **Success**
- Quality Update Status: **Running**
- Feature Update Status: **Running**
- Policy conflicts: **0**
- Deployment errors: **0**

## 🧾 Final Result

The Windows Update Ring policy was successfully deployed to the pilot security group and validated on `LAB-WIN-01`. Windows Update settings, Intune reporting, and endpoint verification confirmed the device received the configured update policy with controlled deployment settings, no policy conflicts, and no deployment errors.
