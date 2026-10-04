# 006 — Trusted Root Certificate Deployment

> **Context:** Personal lab

**Platform:** Microsoft Intune  
**Target Group:** SG-PILOT-Intune-Devices  
**Validation Device:** LAB-WIN-01

## Request

Create, deploy, and validate a Trusted Root Certificate through Microsoft Intune to establish certificate trust on managed Windows pilot devices.

## Business Purpose

Trusted Root Certificates establish trust between managed endpoints and enterprise resources. They provide the foundation for:

- Certificate-based authentication
- Enterprise Wi-Fi (EAP-TLS)
- VPN authentication
- Internal web applications
- Public Key Infrastructure (PKI)
- SCEP certificate deployment
- PKCS certificate deployment

Deploying Trusted Root Certificates through Microsoft Intune provides centralized certificate management while ensuring enterprise trust is consistently applied across managed Windows devices.

## Administrative Location

**Portal:** Microsoft Intune Admin Center

**Navigation**

`Devices → Windows → Configuration profiles`

## Actions Performed

### 1. Create the Trusted Certificate Profile

1. Open the **Microsoft Intune Admin Center**.
2. Navigate to:

   `Devices → Windows → Configuration profiles`

3. Select **Create → New policy**.
4. Configure:

   - **Platform:** Windows 10 and later
   - **Profile Type:** Templates
   - **Template:** Trusted certificate

5. Select **Create**.
6. Enter the policy name and description.
7. Continue to the configuration settings.

**Configuration Details**

- **Policy Name:** `WIN-CFG-Pilot-Trusted-Root-Certificate`
- **Platform:** Windows 10 and later
- **Profile Type:** Trusted Certificate
- **Deployment Scope:** Pilot devices

### 2. Create the Lab Root Certificate

1. Connect to `LAB-WIN-01` using Remote Desktop.
2. Open **Windows PowerShell** as Administrator.
3. Run the following PowerShell commands:

   ```powershell
   $cert = New-SelfSignedCertificate `
     -Type Custom `
     -Subject "CN=TracIT Lab Root CA" `
     -FriendlyName "TracIT Lab Root CA" `
     -KeyAlgorithm RSA `
     -KeyLength 2048 `
     -HashAlgorithm SHA256 `
     -KeyUsage CertSign, CRLSign, DigitalSignature `
     -TextExtension @("2.5.29.19={critical}{text}ca=TRUE") `
     -CertStoreLocation "Cert:\LocalMachine\My" `
     -NotAfter (Get-Date).AddYears(5)

   New-Item `
     -ItemType Directory `
     -Path "C:\TracIT-Certs" `
     -Force

   Export-Certificate `
     -Cert $cert `
     -FilePath "C:\TracIT-Certs\TracIT-Lab-Root-CA.cer"
   ```

4. Confirm the certificate exports successfully.
5. Open **File Explorer** and navigate to:

   `C:\TracIT-Certs`

6. Verify the following file exists:

   `TracIT-Lab-Root-CA.cer`

**Certificate Creation Details**

- **Certificate Name:** TracIT Lab Root CA
- **Subject:** CN=TracIT Lab Root CA
- **Certificate Type:** Self-Signed Root CA
- **Key Algorithm:** RSA
- **Key Length:** 2048 bits
- **Hash Algorithm:** SHA256
- **Key Usage:** Certificate Signing, CRL Signing, Digital Signature
- **Certificate Store:** Local Computer Personal Store
- **Validity:** Five years
- **Export Format:** Public `.CER`
- **Export Location:** `C:\TracIT-Certs`
- **Exported File:** `TracIT-Lab-Root-CA.cer`
- **Private Key Exported:** No

### 3. Configure the Trusted Certificate Profile

1. On the **Configuration settings** page, select the certificate-file folder icon.
2. Upload:

   `TracIT-Lab-Root-CA.cer`

3. Configure the destination store:

   `Computer certificate store - Root`

4. Review the completed certificate configuration.
5. Select **Next**.

**Certificate Profile Configuration**

- **Certificate File:** `TracIT-Lab-Root-CA.cer`
- **Destination Store:** Computer certificate store - Root
- **Certificate Type:** Trusted Root Certificate
- **Private Key Included:** No

### 4. Assign the Policy

1. Continue to the **Assignments** page.
2. Add the following included security group:

   `SG-PILOT-Intune-Devices`

3. Confirm the group contains `LAB-WIN-01`.
4. Leave **Excluded groups** empty.
5. Leave **Applicability Rules** blank.
6. Review the deployment configuration.
7. Select **Create**.

**Assignment Details**

- **Assignment Type:** Included group
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Group Membership:** One pilot device
- **Deployment Method:** Pilot device group
- **Excluded Groups:** None
- **Applicability Rules:** None

### 5. Standardize the Policy Name

1. Return to:

   `Devices → Windows → Configuration profiles`

2. Open the newly created Trusted Certificate profile.
3. Navigate to **Properties**.
4. Edit the **Basics** section.
5. Rename the policy to:

   `WIN-CFG-Pilot-Trusted-Root-Certificate`

6. Save the updated policy name.
7. Confirm the policy appears with the established configuration-policy naming convention.

**Naming Convention**

- `WIN` identifies the Windows platform.
- `CFG` identifies a configuration policy.
- `Pilot` identifies the deployment phase.
- `Trusted-Root-Certificate` identifies the policy function.

### 6. Sync the Pilot Device

1. In the **Microsoft Intune Admin Center**, navigate to:

   `Devices → Windows → Windows devices`

2. Open `LAB-WIN-01`.
3. Select **Sync**.
4. Confirm the synchronization request.
5. Allow the endpoint time to complete a new Intune check-in.

**Sync Details**

- Trusted Certificate profile targeted to the pilot endpoint
- Device synchronization initiated from Intune
- Device completed a new Intune check-in
- No device-action errors reported

## Validation

### 1. Intune Policy Validation

1. Return to:

   `Devices → Windows → Configuration profiles`

2. Confirm the following policy appears:

   `WIN-CFG-Pilot-Trusted-Root-Certificate`

3. Review the policy type and platform.
4. Confirm the policy remains assigned to:

   `SG-PILOT-Intune-Devices`

**Policy Results**

- **Policy Name:** `WIN-CFG-Pilot-Trusted-Root-Certificate`
- **Policy Type:** Trusted certificate
- **Displayed Platform:** Windows 8.1 and later
- **Target Group:** `SG-PILOT-Intune-Devices`
- **Configuration Errors:** None observed

The Trusted Certificate template displays as **Windows 8.1 and later** in the Intune policy list even though the policy was created for and deployed to a Windows 11 endpoint.

### 2. Certificate Store Validation

1. On `LAB-WIN-01`, open the Start menu.
2. Search for:

   `Manage computer certificates`

3. Open **Certificates - Local Computer**.
4. Navigate to:

   `Trusted Root Certification Authorities → Certificates`

5. Locate:

   `TracIT Lab Root CA`

6. Confirm the certificate appears in the Local Computer Trusted Root certificate store.

**Certificate Store Results**

- Certificate deployed successfully
- Certificate installed under Trusted Root Certification Authorities
- **Issued To:** TracIT Lab Root CA
- **Issued By:** TracIT Lab Root CA
- Certificate visible in Windows Certificate Manager

### 3. Certificate Property Validation

1. Double-click `TracIT Lab Root CA`.
2. Review the **General** tab.
3. Confirm the certificate identity and validity dates.
4. Review the certificate purpose information.

**Certificate Property Results**

- **Issued To:** TracIT Lab Root CA
- **Issued By:** TracIT Lab Root CA
- **Certificate Type:** Self-Signed Root CA
- **Valid From:** 07/30/2026
- **Valid To:** 07/30/2031
- **Certificate Purpose:** All issuance policies
- **Application Purpose:** All application policies

Because the certificate is self-signed, the **Issued To** and **Issued By** values are identical.

### 4. PowerShell Validation

1. On `LAB-WIN-01`, open **Windows PowerShell**.
2. Run:

   ```powershell
   Get-ChildItem Cert:\LocalMachine\Root |
     Where-Object { $_.Subject -like "*TracIT*" }
   ```

3. Review the command output.
4. Confirm the certificate is returned from the Local Computer Root certificate store.

**Expected PowerShell Result**

- The certificate subject contains `CN=TracIT Lab Root CA`
- The certificate appears in `Cert:\LocalMachine\Root`
- The certificate thumbprint and expiration date are returned
- The certificate is available to the local computer as a trusted root

## Final Result

The Trusted Root Certificate profile was successfully created in Microsoft Intune and assigned to `SG-PILOT-Intune-Devices`.

A self-signed Root CA certificate was generated on `LAB-WIN-01` using Windows PowerShell, exported as the public `TracIT-Lab-Root-CA.cer` file, uploaded to Intune, and deployed to the Local Computer Trusted Root Certification Authorities certificate store.

The deployment was validated through the Intune configuration-policy list, Windows Certificate Manager, certificate properties, and the Local Computer PowerShell certificate provider. The certificate was successfully installed with a validity period from July 30, 2026, through July 30, 2031, confirming successful end-to-end Trusted Root Certificate deployment.
