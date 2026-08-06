# 008 — Win32 Application Packaging

**Platform:** Microsoft Intune  
**Application Type:** Windows app (Win32)  
**Application:** Microsoft Teams  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## 📌 Request

Package the Microsoft Teams Bootstrapper as a Win32 application using the Microsoft Win32 Content Prep Tool, upload the packaged application into Microsoft Intune, deploy it to the Windows pilot device group, and validate successful application installation and deployment reporting.

## 💼 Business Purpose

Win32 application deployment through Microsoft Intune enables centralized distribution of traditional Windows applications that are not deployed directly through the Microsoft Store.

The Microsoft Win32 Content Prep Tool converts Windows installation files into the `.intunewin` format required by Intune. This enables administrators to define installation and uninstall commands, operating-system requirements, application detection rules, deployment assignments, and reporting.

Using a standardized Win32 packaging and deployment process helps organizations automate application delivery, reduce manual endpoint configuration, support controlled pilot testing, and maintain consistent software configurations across managed Windows devices.

## 🧭 Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Apps → Windows → Windows apps`

**Packaging Tools**

- Windows PowerShell
- Microsoft Win32 Content Prep Tool
- Microsoft Teams Bootstrapper

## ⚙️ Actions Performed

### 1. Download the Microsoft Teams Bootstrapper

1. Open the Microsoft Teams bulk installation documentation.
2. Locate the option to download and install Teams using the Teams Bootstrapper.
3. Download:

   `teamsbootstrapper.exe`

4. Create the following source folder on the macOS administrative workstation:

   `Teams-Deployment/Source`

5. Place `teamsbootstrapper.exe` in the **Source** folder.

**Configuration Details**

- **Application:** Microsoft Teams
- **Installer:** `teamsbootstrapper.exe`
- **Installer Type:** Microsoft Teams Bootstrapper
- **Installation Mode:** Online
- **Source Platform:** macOS
- **Source Folder:** `Teams-Deployment/Source`

### 2. Download the Microsoft Win32 Content Prep Tool

1. Open the Microsoft Win32 Content Prep Tool repository on GitHub.
2. Open the latest release.
3. Download:

   `IntuneWinAppUtil.exe`

4. Create the following tools folder:

   `Teams-Deployment/Tools`

5. Place `IntuneWinAppUtil.exe` in the **Tools** folder.
6. Create an empty output folder:

   `Teams-Deployment/Output`

**Configuration Details**

- **Packaging Tool:** Microsoft Win32 Content Prep Tool
- **Executable:** `IntuneWinAppUtil.exe`
- **Tools Folder:** `Teams-Deployment/Tools`
- **Output Folder:** `Teams-Deployment/Output`
- Packaging tool stored outside the application source folder

### 3. Configure RDP Folder Redirection

1. Open **Microsoft Windows App** on macOS.
2. Edit the saved connection for:

   `LAB-WIN-01`

3. Open the **Folders** configuration tab.
4. Enable:

   `Redirect folders`

5. Add the following macOS project folder:

   `Teams-Deployment`

6. Save the Windows App connection.
7. Connect to `LAB-WIN-01`.
8. Open **File Explorer**.
9. Navigate to:

   `This PC`

10. Confirm the redirected folder appears under **Redirected drives and folders**.

**Configuration Details**

- **Remote Access Tool:** Microsoft Windows App
- **Protocol:** Remote Desktop Protocol
- **Source Device:** macOS administrative workstation
- **Remote Device:** `LAB-WIN-01`
- **Redirected Folder:** `Teams-Deployment`
- **Redirection Status:** Successful

### 4. Copy the Deployment Workspace to LAB-WIN-01

1. On `LAB-WIN-01`, open the redirected `Teams-Deployment` folder.
2. Confirm the following folders are available:

   - `Source`
   - `Tools`
   - `Output`

3. Confirm the following files are present:

   - `Source\teamsbootstrapper.exe`
   - `Tools\IntuneWinAppUtil.exe`

4. Create the following local folder structure:

   `C:\IntuneLab\Teams-Deployment`

5. Copy the full deployment workspace from the redirected macOS folder to the local Windows folder.
6. Confirm the following local structure exists:

```text
C:\IntuneLab\Teams-Deployment
├── Output
├── Source
│   └── teamsbootstrapper.exe
└── Tools
    └── IntuneWinAppUtil.exe
```

**Configuration Details**

- **Local Workspace:** `C:\IntuneLab\Teams-Deployment`
- **Source Folder:** `C:\IntuneLab\Teams-Deployment\Source`
- **Tools Folder:** `C:\IntuneLab\Teams-Deployment\Tools`
- **Output Folder:** `C:\IntuneLab\Teams-Deployment\Output`
- Files copied locally before application packaging
- Proxmox console retained for break-glass access

### 5. Package the Microsoft Teams Application

1. On `LAB-WIN-01`, open **Windows PowerShell** as Administrator.
2. Run:

```powershell
& "C:\IntuneLab\Teams-Deployment\Tools\IntuneWinAppUtil.exe" `
  -c "C:\IntuneLab\Teams-Deployment\Source" `
  -s "teamsbootstrapper.exe" `
  -o "C:\IntuneLab\Teams-Deployment\Output"
```

3. Wait for the packaging utility to validate the parameters.
4. Allow the tool to compress and encrypt the source application.
5. Confirm the SHA256 hash and detection metadata are generated.
6. Confirm the package-generation process reaches 100 percent.
7. Confirm the following output file is created:

   `teamsbootstrapper.intunewin`

**Packaging Details**

- **Source Folder:** `C:\IntuneLab\Teams-Deployment\Source`
- **Setup File:** `teamsbootstrapper.exe`
- **Output Folder:** `C:\IntuneLab\Teams-Deployment\Output`
- **Output Package:** `teamsbootstrapper.intunewin`
- **Package Type:** `.intunewin`
- **Packaging Status:** Successful

### 6. Transfer the Win32 Package to the Administrative Workstation

1. Open the local output folder on `LAB-WIN-01`:

   `C:\IntuneLab\Teams-Deployment\Output`

2. Confirm the following generated package is present:

   `teamsbootstrapper.intunewin`

3. Open the redirected macOS `Teams-Deployment` folder.
4. Copy `teamsbootstrapper.intunewin` from the Windows output folder to the redirected macOS workspace.
5. Confirm the package is available on the macOS administrative workstation.
6. Use the macOS browser session to upload the package into Microsoft Intune.

**Transfer Details**

- **Source:** `C:\IntuneLab\Teams-Deployment\Output\teamsbootstrapper.intunewin`
- **Destination:** macOS `Teams-Deployment` workspace
- **Transfer Method:** Bi-directional RDP folder redirection
- **Purpose:** Make the generated Win32 package available to the browser session used for Microsoft Intune administration
- **Transfer Status:** Successful

## ✅ Validation

### 1. Deployment Workspace Validation

1. Open:

   `C:\IntuneLab\Teams-Deployment`

2. Confirm the following folders exist:

   - `Output`
   - `Source`
   - `Tools`

3. Confirm the application source and packaging utility are stored in their expected folders.
4. Confirm the application source folder does not contain the packaging utility.

**Workspace Results**

- Deployment workspace created successfully
- Source, tools, and output folders created successfully
- `teamsbootstrapper.exe` stored in the source folder
- `IntuneWinAppUtil.exe` stored outside the source folder
- Deployment files copied successfully from macOS to `LAB-WIN-01`

### 2. RDP Folder Redirection Validation

1. Open **File Explorer** on `LAB-WIN-01`.
2. Navigate to:

   `This PC`

3. Review **Redirected drives and folders**.
4. Confirm the macOS `Teams-Deployment` folder appears.
5. Open the redirected folder.
6. Confirm its files and subfolders are accessible.

**Redirection Results**

- macOS deployment workspace visible from `LAB-WIN-01`
- Redirected folder opened successfully
- Source and tool files accessible through the remote session
- No folder-redirection or file-access errors reported

### 3. Win32 Package Validation

1. Review the PowerShell output.
2. Confirm the packaging utility reports:

   - Parameters validated
   - Source folder compressed
   - Package encrypted
   - SHA256 hash generated
   - Detection XML generated
   - Temporary files removed
   - Output package generated successfully

3. Open:

   `C:\IntuneLab\Teams-Deployment\Output`

4. Confirm the following file exists:

   `teamsbootstrapper.intunewin`

**Packaging Results**

- **Output Package:** `teamsbootstrapper.intunewin`
- **Package Location:** `C:\IntuneLab\Teams-Deployment\Output`
- PowerShell packaging process completed successfully
- Package generation reached 100 percent
- No packaging errors reported
- Win32 application package ready for upload to Microsoft Intune

## 🧾 Final Result

The Microsoft Teams Bootstrapper was successfully prepared and converted into the `.intunewin` format using the Microsoft Win32 Content Prep Tool.

The deployment source and packaging utility were organized into separate folders, transferred from the macOS administrative workstation to `LAB-WIN-01` using Microsoft Windows App with RDP folder redirection, and copied to a local Windows deployment workspace.

The packaging process completed successfully through Windows PowerShell. The resulting `teamsbootstrapper.intunewin` package was generated in the designated output folder with no errors and is ready for configuration and deployment through Microsoft Intune.
