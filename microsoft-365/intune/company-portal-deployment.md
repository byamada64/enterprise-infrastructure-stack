# 007 — Company Portal Application Deployment

> **Context:** Personal lab

**Platform:** Microsoft Intune  
**Application Type:** Microsoft Store app (new)  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Deploy Microsoft Company Portal to managed Windows pilot devices through Microsoft Intune and validate successful application installation, endpoint functionality, and deployment reporting.

## 💼 Business Purpose

Application deployment through Microsoft Intune enables centralized software distribution across managed Windows endpoints without requiring manual installation by IT staff.

Required applications can be installed automatically during device provisioning, helping organizations standardize endpoint builds, reduce onboarding time, and ensure users receive approved business applications.

Microsoft Company Portal also provides a self-service application catalog where users can install applications made available by IT while administrators retain centralized control over application assignments, installation status, and lifecycle management.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Apps → Windows → Windows apps`

## ⚙️ Actions Performed

### 1. Create the Microsoft Store Application

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Apps → Windows → Windows apps`

3. Select **Create**.
4. Select the following application type:

   `Microsoft Store app (new)`

5. Select **Search the Microsoft Store app (new)**.
6. Search for:

   `Company Portal`

7. Select the application published by **Microsoft Corporation**.
8. Continue to the application configuration.

**Configuration Details**

- **Application Name:** Company Portal
- **Publisher:** Microsoft Corporation
- **Application Type:** Microsoft Store app (new)
- **Installer Type:** UWP
- **Package Identifier:** `9WZDNCRFJ3PZ`
- **Operating System:** Windows

### 2. Configure the Application Information

1. Review the application information populated from the Microsoft Store.
2. Configure the application category:

   `Productivity`

3. Configure the installation behavior:

   `System`

4. Leave **Show this as a featured app in the Company Portal** set to **No**.
5. Configure the application owner:

   `TracIT Endpoint Administration`

6. Add the following administrative note:

   `Pilot deployment of Company Portal to managed Windows devices.`

7. Leave the Microsoft-provided application name, description, publisher, and package information unchanged.
8. Continue to the assignment configuration.

**Configuration Details**

- **Application Name:** Company Portal
- **Publisher:** Microsoft Corporation
- **Category:** Productivity
- **Install Behavior:** System
- **Featured Application:** No
- **Owner:** TracIT Endpoint Administration
- **Notes:** Pilot deployment of Company Portal to managed Windows devices
- **Information URL:** Not configured
- **Developer:** Not configured
- **Logo:** Microsoft Store application logo

### 3. Assign the Application

1. Continue to the **Assignments** page.
2. Under **Required**, select **Add group**.
3. Add:

   `SG-PILOT-Intune-Devices`

4. Confirm the assignment is active.
5. Leave **Available for enrolled devices** empty.
6. Leave **Uninstall** empty.
7. Review the deployment settings.
8. Continue to **Review + create**.

**Assignment Details**

- **Assignment Type:** Required
- **Group Mode:** Included
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Assignment Status:** Active
- **Filter Mode:** None
- **Filter:** None
- **End User Notifications:** Show all toast notifications
- **Installation Deadline:** As soon as possible
- **Restart Grace Period:** Disabled
- **Available Assignment:** None
- **Uninstall Assignment:** None

### 4. Create the Application

1. Review the application information.
2. Confirm the application type is:

   `Microsoft Store app (new)`

3. Confirm the installation behavior is:

   `System`

4. Confirm the required assignment targets:

   `SG-PILOT-Intune-Devices`

5. Select **Create**.
6. Open the newly created **Company Portal** application.
7. Confirm the application object appears in Intune.

**Configuration Details**

- **Application:** Company Portal
- **Publisher:** Microsoft Corporation
- **Operating System:** Windows
- **Assigned:** Yes
- **Deployment Method:** Required
- **Target Scope:** Pilot device group
- **Application Creation Status:** Successful

### 5. Sync the Pilot Device

1. Restart `LAB-WIN-01`.
2. Sign in to the Windows endpoint.
3. Navigate to:

   `Settings → Accounts → Access work or school`

4. Select the connected organizational account.
5. Select **Info**.
6. Select **Sync**.
7. Wait for the device to complete the Intune synchronization.

**Sync Details**

- Company Portal assignment targeted to the pilot endpoint
- Device restarted before validation
- Manual synchronization initiated from Windows
- **Last Attempted Sync:** Successful
- **Synchronization Time:** 07/30/2026 9:31:53 AM
- No synchronization errors reported

## ✅ Validation

### 1. Intune Application Validation

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Apps → Windows → Windows apps`

2. Open **Company Portal**.
3. Review the application overview.
4. Confirm the application is assigned.
5. Confirm the application object contains the expected publisher and operating-system information.

**Application Results**

- **Application Name:** Company Portal
- **Publisher:** Microsoft Corporation
- **Operating System:** Windows
- **Assigned:** Yes
- Application object created successfully
- Required assignment configured successfully

### 2. Device Synchronization Validation

1. On `LAB-WIN-01`, open the connected work-account information.
2. Review the synchronization status.
3. Confirm the latest synchronization attempt completed successfully.
4. Confirm no device synchronization errors were reported.

**Sync Results**

- **Validation Device:** `LAB-WIN-01`
- Device synchronization completed successfully
- Latest synchronization status reported as successful
- No synchronization errors detected

### 3. Endpoint Application Validation

1. On `LAB-WIN-01`, open the Start menu.
2. Search for:

   `Company Portal`

3. Launch the application.
4. Confirm Company Portal opens successfully.
5. Confirm the signed-in managed user is recognized.
6. Confirm the application identifies `LAB-WIN-01` as the current device.
7. Confirm no application launch or authentication errors appear.

**Endpoint Results**

- Company Portal installed and launched successfully
- Managed user authenticated successfully
- `LAB-WIN-01` displayed as **This device**
- Application communicated successfully with Microsoft Intune
- No application launch or authentication errors appeared

Company Portal displayed that no applications were available to the user. This was expected because no applications had been assigned as **Available for enrolled devices**.

### 4. Intune Deployment Reporting Validation

1. Return to the **Company Portal** application in Intune.
2. Review the **Device status** summary.
3. Review the **User status** summary.
4. Confirm the application reports successful installation.
5. Confirm no failed, pending, or not-applicable deployments are reported.

**Deployment Results**

- **Device Status:** Installed — confirms `LAB-WIN-01` successfully installed the application.
- **User Status:** Installed — confirms the signed-in managed user successfully received and reported the deployment.
- No failed or pending deployments were reported.

## 🧾 Final Result

Microsoft Company Portal was successfully deployed to `LAB-WIN-01` through Microsoft Intune using the **Microsoft Store app (new)** deployment model.

The application was configured with **System** install behavior, assigned as a **Required** application to `SG-PILOT-Intune-Devices`, synchronized to the managed Windows endpoint, and launched successfully.

Deployment was validated through endpoint testing, device recognition in Company Portal, successful Intune synchronization, and application deployment reporting. Both the device and user status views reported the installation as successful, with no failed or pending deployments, confirming successful end-to-end application deployment.
