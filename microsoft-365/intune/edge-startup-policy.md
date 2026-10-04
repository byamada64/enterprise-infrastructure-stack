# 001 — Microsoft Edge Startup Policy

> **Context:** Personal lab

**Platform:** Microsoft Intune  
**Target Group:** Pilot device group  
**Validation Device:** LAB-WIN-01

## 📌 Request

Configure Microsoft Edge so pilot devices automatically open the Microsoft 365 portal when the browser starts.

## 💼 Business Purpose

Provide pilot users with immediate access to Microsoft 365 applications and services when Microsoft Edge launches, reducing navigation steps and creating a consistent startup experience.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Devices → Windows → Configuration profiles`

## ⚙️ Actions Performed

### 1. Create the Settings Catalog Profile

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Configuration profiles`

3. Select **Create → New policy**.
4. Configure:
   - **Platform:** Windows 10 and later
   - **Profile type:** Settings catalog
5. Enter the policy name and description.
6. Continue to the configuration settings.

**Configuration Details**

- **Policy type:** Windows Settings Catalog
- **Purpose:** Configure Microsoft Edge startup behavior
- **Deployment scope:** Pilot devices

### 2. Configure the Microsoft Edge Startup Policy

1. Select **Add settings**.
2. Search for the Microsoft Edge startup settings.
3. Configure Microsoft Edge to open a specified list of URLs when the browser starts.
4. Add:

   `https://portal.office.com`

5. Review the configured settings.

**Configuration Details**

- **Browser:** Microsoft Edge
- **Startup behavior:** Open configured URLs
- **Startup URL:** `https://portal.office.com`

### 3. Assign the Policy

1. Continue to the **Assignments** page.
2. Select the pilot device group.
3. Review the included group.
4. Review the deployment scope.
5. Save and create the policy.

**Assignment Details**

- **Assignment Type:** Included group
- **Target Group:** Pilot device group

### 4. Sync the Pilot Device

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Devices → Windows → Windows devices`

2. Open `LAB-WIN-01`.
3. Select **Sync**.
4. Confirm the synchronization request.
5. Allow the endpoint time to complete a new Intune check-in.

**Sync Details**

- Microsoft Edge startup policy targeted to the pilot endpoint
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

### 3. Microsoft Edge UI Validation

1. On `LAB-WIN-01`, close Microsoft Edge if it is already running.
2. Reopen Microsoft Edge.
3. Confirm the Microsoft 365 portal opens automatically.
4. Confirm the configured startup URL loads successfully.
5. Confirm no browser startup or policy errors are displayed.

**Microsoft Edge Results**

- Microsoft Edge launched successfully
- Microsoft 365 portal opened automatically
- Configured startup behavior applied to the pilot endpoint
- No startup or policy errors displayed

### 4. Intune Report Validation

1. Return to the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Configuration profiles`

3. Open the Microsoft Edge startup policy.
4. Open the device assignment report.
5. Regenerate or refresh the report.
6. Locate `LAB-WIN-01`.
7. Confirm the assignment status.

**Report Results**

- **Assignment Status:** Success
- **Policy Conflicts:** 0
- **Deployment Errors:** 0

## 🧾 Final Result

The Microsoft Edge startup policy was successfully created, assigned to the pilot device group, and validated on `LAB-WIN-01`. Microsoft Edge opened the Microsoft 365 portal automatically, and Intune reporting confirmed a successful deployment with no policy conflicts or errors.
