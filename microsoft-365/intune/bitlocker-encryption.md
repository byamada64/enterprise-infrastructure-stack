# 003 — BitLocker Endpoint Security Policy

> **Context:** Personal lab

**Platform:** Microsoft Intune  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Configure Microsoft Intune Endpoint Security to automatically encrypt Windows devices using BitLocker with TPM protection and securely escrow recovery keys to Microsoft Entra ID.

## 💼 Business Purpose

Protect organizational data by enforcing full-disk encryption on managed Windows devices while ensuring recovery keys are securely stored in Microsoft Entra ID for administrative recovery and compliance.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Endpoint security → Disk encryption`

## ⚙️ Actions Performed

### 1. Create the Disk Encryption Policy

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Endpoint security → Disk encryption`

3. Select **Create Policy**.
4. Configure:
   - **Platform:** Windows
   - **Profile:** BitLocker
5. Enter the policy name and description.
6. Configure the BitLocker policy settings.
7. Review the configuration.
8. Create the policy.

**Configuration Details**

- **Encryption technology:** BitLocker
- **Operating system drive encryption:** Enabled
- **TPM startup authentication:** Required
- **Recovery information:** Back up to Microsoft Entra ID

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
5. Allow the device time to complete a new Intune check-in.

**Sync Details**

- BitLocker policy targeted to the pilot endpoint
- Device synchronization initiated from Intune
- Recovery-key escrow configured for Microsoft Entra ID

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
5. Confirm TPM 2.0 or a virtual TPM is available to the operating system.
6. Open the virtual-machine console or connect through Remote Desktop.
7. Sign in using the lab user account.

**Environment Details**

- **Virtualization Platform:** Proxmox VE
- **Validation Device:** `LAB-WIN-01`
- **Operating System:** Windows 11
- **TPM:** Virtual TPM 2.0 enabled
- **Access Method:** Remote Desktop or Proxmox console

### 3. Windows UI Validation

1. On `LAB-WIN-01`, open **Control Panel**.
2. Navigate to:

   `Control Panel → BitLocker Drive Encryption`

3. Locate the operating system drive.
4. Confirm BitLocker is enabled.
5. Confirm the drive encryption process is complete.

**Windows UI Results**

- BitLocker enabled
- Operating system drive protected
- Drive encryption completed successfully

### 4. Command-Line Encryption Validation

1. On `LAB-WIN-01`, select **Start**.
2. Search for **Command Prompt**.
3. Select **Run as administrator**.
4. Approve the User Account Control prompt.
5. Run:

```cmd
manage-bde -status
```

6. Review:
   - Conversion Status
   - Percentage Encrypted
   - Protection Status
   - Encryption Method
   - Key Protectors

**Command-Line Results**

- **Conversion Status:** Fully Encrypted
- **Percentage Encrypted:** 100%
- **Protection Status:** On
- TPM protector configured
- Recovery Password protector configured

### 5. TPM Validation

1. On `LAB-WIN-01`, press **Windows + R**.
2. Enter:

   `tpm.msc`

3. Select **OK**.
4. Review the TPM Management console.
5. Confirm the TPM is ready for use.
6. Confirm the specification version is TPM 2.0.

**TPM Results**

- TPM status healthy
- TPM ready for use
- TPM specification version: **2.0**

### 6. Intune Encryption Report Validation

1. Return to the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Endpoint security → Disk encryption`

3. Open the BitLocker policy.
4. Open the applicable encryption or device-status report.
5. Regenerate or refresh the report.
6. Locate `LAB-WIN-01`.
7. Review the encryption and deployment status.

**Encryption Report Results**

- **Encryption Status:** Encrypted
- Policy assignment successful
- Policy conflicts: **0**
- Deployment errors: **0**

### 7. Recovery Key Validation

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Devices → Windows → Windows devices`

2. Open `LAB-WIN-01`.
3. Select **Recovery keys**.
4. Locate the BitLocker recovery-key entry.
5. Confirm the recovery key is associated with the correct device.
6. Confirm the recovery information is available for administrative recovery.

**Recovery Key Results**

- BitLocker recovery key successfully escrowed
- Recovery key associated with `LAB-WIN-01`
- Recovery information available through Microsoft Entra ID

## 🧾 Final Result

The BitLocker Endpoint Security policy was successfully deployed to the pilot security group and validated on `LAB-WIN-01`. Endpoint readiness, Windows UI, command-line, TPM, Intune reporting, and recovery-key validation confirmed full-disk encryption, active TPM protection, and successful recovery-key escrow to Microsoft Entra ID with no policy conflicts or deployment errors.
