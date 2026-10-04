# 009 — Microsoft Teams Win32 Deployment

> **Context:** Personal lab

**Platform:** Microsoft Intune  
**Application Type:** Windows app (Win32)  
**Application:** Microsoft Teams  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Upload the packaged Microsoft Teams Win32 application into Microsoft Intune, configure the application requirements and deployment settings, assign it to the Windows pilot device group, and validate successful installation and deployment reporting.

## 💼 Business Purpose

Win32 application deployment through Microsoft Intune enables centralized installation and lifecycle management of traditional Windows applications across managed endpoints.

Separating application packaging from deployment allows administrators to independently validate the installer package before configuring production deployment settings such as installation commands, operating-system requirements, detection rules, assignments, and reporting.

Deploying applications first to a controlled pilot group reduces rollout risk, allows administrators to identify configuration or compatibility issues, and provides an opportunity to validate endpoint behavior before expanding the deployment to additional users or devices.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Apps → Windows → Windows apps`

## ⚙️ Actions Performed

### 1. Create the Win32 Application

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Apps → Windows → Windows apps`

3. Select **Create**.
4. Select the following application type:

   `Windows app (Win32)`

5. Upload the packaged application:

   `teamsbootstrapper.intunewin`

6. Wait for Microsoft Intune to process the application package.
7. Continue to the application-information configuration.

**Configuration Details**

- **Application Type:** Windows app (Win32)
- **App Package File:** `teamsbootstrapper.intunewin`
- **Original Setup File:** `teamsbootstrapper.exe`
- **Operating System:** Windows
- **Package Upload Status:** Successful

### 2. Configure the Application Information

1. Replace the automatically populated application name with:

   `Microsoft Teams`

2. Configure the application description:

   `Microsoft Teams desktop client deployed to managed Windows pilot devices through Microsoft Intune using the Teams Bootstrapper.`

3. Configure the publisher:

   `Microsoft Corporation`

4. Leave **App Version** blank.
5. Configure the application category:

   `Productivity`

6. Leave **Show this as a featured app in the Company Portal** set to **No**.
7. Leave **Information URL** blank.
8. Leave **Privacy URL** blank.
9. Configure the developer:

   `Microsoft Corporation`

10. Configure the application owner:

    `TracIT Endpoint Administration`

11. Add the following administrative note:

    `Pilot Win32 deployment of Microsoft Teams to managed Windows devices.`

12. Leave the application logo unconfigured.
13. Continue to the program configuration.

**Configuration Details**

- **Application Name:** Microsoft Teams
- **Description:** Microsoft Teams desktop client deployed to managed Windows pilot devices through Microsoft Intune using the Teams Bootstrapper
- **Publisher:** Microsoft Corporation
- **App Version:** Not configured
- **Category:** Productivity
- **Featured Application:** No
- **Information URL:** Not configured
- **Privacy URL:** Not configured
- **Developer:** Microsoft Corporation
- **Owner:** TracIT Endpoint Administration
- **Notes:** Pilot Win32 deployment of Microsoft Teams to managed Windows devices
- **Logo:** Not configured

### 3. Configure the Program Settings

1. Configure the installation command:

   `teamsbootstrapper.exe -p`

2. Configure the uninstall command:

   `teamsbootstrapper.exe -x -m`

3. Leave the installation time requirement set to:

   `60 minutes`

4. Configure **Allow available uninstall** as:

   `No`

5. Configure the installation behavior as:

   `System`

6. Configure the device restart behavior as:

   `No specific action`

7. Leave the default return codes unchanged.
8. Continue to the application requirements.

**Program Details**

- **Installer Type:** Command line
- **Install Command:** `teamsbootstrapper.exe -p`
- **Uninstaller Type:** Command line
- **Uninstall Command:** `teamsbootstrapper.exe -x -m`
- **Installation Time Required:** 60 minutes
- **Allow Available Uninstall:** No
- **Install Behavior:** System
- **Device Restart Behavior:** No specific action

**Return Codes**

- **0:** Success
- **1707:** Success
- **3010:** Soft reboot
- **1641:** Hard reboot
- **1618:** Retry

### 4. Configure the Application Requirements

1. Configure Intune to evaluate the operating-system architecture.
2. Select:

   `Install on x64 system`

3. Leave the following architectures unselected:

   - Install on x86 system
   - Install on ARM64 system

4. Configure the minimum operating system:

   `Windows 10 2004`

5. Configure the required disk space:

   `3000 MB`

6. Configure the required physical memory:

   `4096 MB`

7. Configure the minimum number of logical processors:

   `2`

8. Configure the minimum CPU speed:

   `1100 MHz`

9. Leave additional requirement rules empty.
10. Continue to the detection-rule configuration.

**Requirement Details**

- **Architecture Evaluation:** Enabled
- **Supported Architecture:** x64
- **x86:** Not selected
- **ARM64:** Not selected
- **Minimum Operating System:** Windows 10 2004
- **Disk Space Required:** 3000 MB
- **Physical Memory Required:** 4096 MB
- **Minimum Logical Processors:** 2
- **Minimum CPU Speed:** 1100 MHz
- **Additional Requirement Rules:** None

### 5. Create the Microsoft Teams Detection Script

1. On the macOS administrative workstation, create the following folder:

   `Teams-Deployment/Scripts`

2. Create the following PowerShell script:

   `Detect-MicrosoftTeams.ps1`

3. Add the following detection logic:

See [`Detect-MicrosoftTeams.ps1`](Detect-MicrosoftTeams.ps1)

4. Save the script in the macOS deployment workspace.
5. Confirm the script is available for direct upload into Microsoft Intune.

**Configuration Details**

- **Script Name:** `Detect-MicrosoftTeams.ps1`
- **Script Location:** `Teams-Deployment/Scripts`
- **Source Platform:** macOS administrative workstation
- **Detection Target:** `MSTeams`
- **Detection Scope:** All users
- **Successful Detection:** Exit code `0` with output
- **Application Not Detected:** Exit code `1`
- **Upload Method:** Direct upload from macOS to Microsoft Intune

### 6. Configure the Application Detection Rule

1. On the **Detection rules** page, configure the rules format as:

   `Use a custom detection script`

2. Upload:

   `Detect-MicrosoftTeams.ps1`

3. Configure **Run script as 32-bit process on 64-bit clients** as:

   `No`

4. Configure **Enforce script signature check and run script silently** as:

   `No`

5. Confirm the script content appears in the Intune configuration page.
6. Continue to the dependency configuration.

**Configuration Details**

- **Rules Format:** Use a custom detection script
- **Script File:** `Detect-MicrosoftTeams.ps1`
- **Run as 32-bit Process:** No
- **Enforce Script Signature Check:** No
- **Detected Package:** `MSTeams`
- **Detection Scope:** Machine-wide application package
- **Script Upload Status:** Successful

### 7. Configure Dependencies

1. Review the **Dependencies** page.
2. Confirm Microsoft Teams does not require another Intune-managed application to be installed first.
3. Leave the dependency list empty.
4. Continue to the supersedence configuration.

**Configuration Details**

- **Dependencies:** None
- **Automatically Installed Dependencies:** None
- **Dependency Configuration:** Not required

### 8. Configure Supersedence

1. Review the **Supersedence** page.
2. Confirm this is a new pilot deployment.
3. Leave the supersedence list empty.
4. Continue to the assignment configuration.

**Configuration Details**

- **Supersedence:** None
- **Previous Application Replacement:** Not configured
- **Application Upgrade Relationship:** Not configured

### 9. Assign Microsoft Teams to the Pilot Group

1. On the **Assignments** page, locate the **Required** section.
2. Select **Add group**.
3. Add:

   `SG-PILOT-Intune-Devices`

4. Confirm the group is included and active.
5. Leave **Available for enrolled devices** empty.
6. Leave **Uninstall** empty.
7. Continue to **Review + create**.

**Configuration Details**

- **Assignment Type:** Required
- **Group Mode:** Included
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Assignment Status:** Active
- **Filter Mode:** None
- **Filter:** None
- **Available Assignment:** None
- **Uninstall Assignment:** None

### 10. Review and Create the Application

1. Review the application summary.
2. Confirm the application package is:

   `teamsbootstrapper.intunewin`

3. Confirm the application name is:

   `Microsoft Teams`

4. Confirm the installation behavior is:

   `System`

5. Confirm the supported architecture is:

   `x64`

6. Confirm the minimum operating system is:

   `Windows 10 2004`

7. Confirm the custom detection script is configured.
8. Confirm the required assignment targets:

   `SG-PILOT-Intune-Devices`

9. Select **Create**.
10. Wait for the application upload and creation process to complete.
11. Open the newly created **Microsoft Teams** application.
12. Confirm the application reports:

    `Assigned: Yes`

**Configuration Details**

- **Application:** Microsoft Teams
- **Publisher:** Microsoft Corporation
- **Operating System:** Windows
- **Application Type:** Windows app (Win32)
- **App Package File:** `teamsbootstrapper.intunewin`
- **Install Behavior:** System
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Assigned:** Yes
- **Application Creation Status:** Successful

### 11. Synchronize the Pilot Device

1. On `LAB-WIN-01`, navigate to:

   `Settings → Accounts → Access work or school`

2. Open the organizational management connection:

   `Managed by TracIT`

3. Select **Info**.
4. Select **Sync**.
5. Wait for the synchronization request to complete.
6. Confirm the device reports a successful synchronization.

**Configuration Details**

- **Validation Device:** `LAB-WIN-01`
- **Management Connection:** Managed by TracIT
- **Manual Synchronization:** Initiated
- **Last Attempted Sync:** Successful
- **Synchronization Time:** 08/03/2026 11:56:58 AM
- No synchronization errors reported

## ✅ Validation

### 1. Intune Application Validation

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Apps → Windows → Windows apps`

2. Confirm **Microsoft Teams** appears in the application list.
3. Confirm the application type is:

   `Windows app (Win32)`

4. Confirm the publisher is:

   `Microsoft Corporation`

5. Confirm the application reports:

   `Assigned: Yes`

**Application Results**

- **Application Name:** Microsoft Teams
- **Platform:** Windows
- **Application Type:** Windows app (Win32)
- **Publisher:** Microsoft Corporation
- **Assigned:** Yes
- Application object created successfully
- Required pilot assignment configured successfully

### 2. Detection Script Validation

1. Open the **Microsoft Teams** application in Intune.
2. Review the configured detection rule.
3. Confirm the following script is uploaded:

   `Detect-MicrosoftTeams.ps1`

4. Confirm the script checks for the machine-wide `MSTeams` package.
5. Confirm successful detection requires exit code `0` and output.
6. Confirm the application was detected after installation.

**Detection Results**

- **Detection Method:** Custom PowerShell script
- **Detection Script:** `Detect-MicrosoftTeams.ps1`
- **Detected Package:** `MSTeams`
- **Detection Scope:** All users
- Microsoft Teams installation detected successfully
- No detection-rule errors reported

### 3. Device Synchronization Validation

1. On `LAB-WIN-01`, open the organizational management connection.
2. Review the device synchronization status.
3. Confirm the latest synchronization completed successfully.
4. Confirm no synchronization errors appear.

**Sync Results**

- **Validation Device:** `LAB-WIN-01`
- Device synchronization completed successfully
- **Last Attempted Sync:** 08/03/2026 11:56:58 AM
- No device synchronization errors reported

### 4. Endpoint Application Validation

1. On `LAB-WIN-01`, open the Start menu.
2. Search for:

   `Microsoft Teams`

3. Confirm Microsoft Teams appears as an installed application.
4. Open Microsoft Teams.
5. Confirm the application launches successfully.
6. Confirm no application installation or launch errors appear.

**Endpoint Results**

- Microsoft Teams installed successfully
- Microsoft Teams appeared in the Windows Start menu
- Application launch option was available
- Required deployment completed through Microsoft Intune
- No installation or application-launch errors appeared

### 5. Intune Deployment Reporting Validation

1. Return to the **Microsoft Teams** application in Intune.
2. Review the **Device status** summary.
3. Review the **User status** summary.
4. Confirm both views report successful installation.
5. Confirm no failed, pending, not-installed, or not-applicable deployments are reported.

**Deployment Results**

- **Device Status — Installed:** 1
- **User Status — Installed:** 1
- **Not Installed:** 0
- **Failed:** 0
- **Install Pending:** 0
- **Not Applicable:** 0
- `LAB-WIN-01` successfully received and installed Microsoft Teams
- Managed user deployment reported successfully

## 🧾 Final Result

Microsoft Teams was successfully deployed to `LAB-WIN-01` through Microsoft Intune using the **Windows app (Win32)** deployment model.

The previously prepared `teamsbootstrapper.intunewin` package was uploaded into Intune and configured with system installation behavior, command-line installation and uninstall commands, x64 architecture requirements, minimum operating-system and hardware requirements, and a custom PowerShell detection script.

The application was assigned as a required deployment to `SG-PILOT-Intune-Devices`. After synchronizing `LAB-WIN-01`, Microsoft Teams installed successfully and appeared in the Windows Start menu.

Deployment was validated through endpoint testing, custom-script detection, successful device synchronization, and Microsoft Intune reporting. Both the device and user status views reported **Installed — 1**, with no failed, pending, not-installed, or not-applicable deployments, confirming successful end-to-end Win32 application deployment.
