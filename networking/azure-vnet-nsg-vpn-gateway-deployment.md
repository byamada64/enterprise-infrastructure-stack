# Azure VNet, NSG & VPN Gateway Deployment

Hands-on Azure networking build focused on segmented virtual networking, subnet-level security, NSG-based firewall controls, and Hybrid Connectivity VPN Gateway deployment.


## 🎯 Objective

Design and deploy an Azure network foundation using:

- Segmented Virtual Network
- Subnet-level NSG security
- Controlled inbound firewall rules
- Hybrid Connectivity VPN Gateway

This build demonstrates enterprise networking concepts including segmentation, access control, policy constraints, and gateway dependencies.


## 🏗️ Environment Build Choices

### Azure Services Used

- Virtual Network (VNet)
- Subnets (segmented architecture)
- Network Security Groups (NSGs)
- Public IP Addresses
- VPN Gateway (Hybrid Connectivity)
- Route Table (prepared for routing)


### Architecture Approach

- Segmented network model (Mgmt, DMZ, App, DB tiers)
- Subnet-level security using NSGs
- Inbound firewall enforcement per subnet
- Dedicated GatewaySubnet for VPN
- Active-Active VPN Gateway configuration
- BGP-enabled routing design (ASN: 65515)


### Design Decisions

- `/24` subnet sizing for workload tiers
- `/27` reserved subnet for GatewaySubnet
- Separate NSG per subnet (isolation model)
- Standard SKU Public IPs (static assignment)
- Hybrid Connectivity deployment path (not standalone resource)


## 💻 Commands Used

### Portal-Based Deployment


## 🔁 ACTUAL BUILD FLOW (Portal-Based — CORRECT ORDER)


### 1️⃣ Create Virtual Network

- Create `corp-vnet`
- Define RFC1918 address space
- Navigate to **Subnets tab**


### 2️⃣ Create Subnets + Assign NSG (CRITICAL STEP)

Create subnets:

- `Management`
- `DMZ`
- `App`
- `DB`

During creation:

- Go to **Security tab**
- Assign NSG from dropdown

| Subnet | NSG |
|--------|-----|
| Management | `mgmt-nsg` |
| DMZ | `dmz-nsg` |
| App | `app-nsg` |
| DB | `db-nsg` |

⚠️ NSGs must exist BEFORE assignment  
⚠️ This replaces manual NSG association later  


### 3️⃣ Create Network Security Groups

Create:

- `mgmt-nsg`
- `dmz-nsg`
- `app-nsg`
- `db-nsg`

(No firewall rules yet)

⚠️ Required before subnet assignment step  


### 4️⃣ Configure Firewall Rules (POST NSG CREATION)

Apply inbound rules AFTER NSG creation:

#### mgmt-nsg
- RDP (3389)
- SSH (22)

#### dmz-nsg
- HTTP (80)
- HTTPS (443)

#### app-nsg
- Internal app ports only

#### db-nsg
- DB ports from App subnet only

⚠️ Firewall rules are applied AFTER NSG creation  


### 5️⃣ Create Gateway Subnet (MANDATORY)

- Name: `GatewaySubnet`
- Size: `/27`

⚠️ Name is case-sensitive  
⚠️ Required for VPN Gateway deployment  


### 6️⃣ Create Public IP Addresses

Create TWO:

- `corp-vpn-pip`
- `corp-vpn-pip02`

Settings:

- SKU: Standard
- Assignment: Static

⚠️ Must exist BEFORE VPN Gateway creation  


## 🌉 HYBRID CONNECTIVITY (KEY STEP)


### 7️⃣ Navigate to VPN Gateway

#### Method 1 (Search)
- Search: **vpn gateway**
- Select: **VPN gateways**

#### Method 2 (Preferred Lab Flow)
- Go to: **Hybrid Connectivity**
- Select:
  - VPN Gateway → **Set up VPN Gateway**

⚠️ Hybrid Connectivity path ensures correct configuration flow  


### 8️⃣ Create VPN Gateway

#### Configuration

- Name: `kk-vpn-gateway`
- Gateway Type: VPN
- VPN Type: RouteBased
- SKU: `VpnGw1AZ`
- Generation: `Generation1`

⚠️ Azure Policy restricts allowed SKUs and Generation  


#### Networking

- Virtual Network: `corp-vnet`
- Subnet: `GatewaySubnet`


#### Public IP Assignment

- Primary: `corp-vpn-pip`
- Secondary: `corp-vpn-pip02`


#### Advanced Settings

- Active-Active: Enabled
- BGP: Enabled
- ASN: `65515`


#### Authentication

- Key Vault: Disabled (not required for lab)


### ⏱️ Deployment Notes

- Deployment time: ~30–45 minutes
- Initial failures due to policy restrictions

⚠️ Azure Policy may block:
- Incorrect SKU
- Wrong Generation
- Incorrect naming  


## ✅ Validation

### Deployment Success

Confirmed:

- `corp-vnet` created
- Subnets correctly segmented
- NSGs applied at subnet level
- Firewall rules active
- Public IPs attached
- `kk-vpn-gateway` deployed  


### Operational Checks

- Network Watcher  
- VPN diagnostics  
- Resource Visualizer  
- Metrics and logs  
- Query Hub  


### Final State

VPN Gateway deployed successfully and operational with monitoring visibility enabled.


## 🧯 Lessons Learned

### Issues Encountered

- Azure Policy blocked invalid SKU and Generation  
- Missing or incorrect `GatewaySubnet`  
- Deployment delays (~30–45 minutes)  
- Incorrect build order caused initial failures  


### Fixes Applied

- Adjusted SKU to allowed value  
- Switched to Generation1  
- Created correct `GatewaySubnet`  
- Used existing Public IPs  
- Followed Hybrid Connectivity workflow  


### Key Takeaways

- Build order matters in Azure networking  
- NSGs must exist before subnet assignment  
- Firewall rules are applied after NSG creation  
- GatewaySubnet is required and name-sensitive  
- Public IPs must exist before gateway creation  
- Hybrid Connectivity path prevents misconfiguration  
- Azure Policy enforces environment constraints  


## 🚀 Future Improvements

- Add Local Network Gateway  
- Configure Site-to-Site VPN  
- Attach Route Tables to subnets  
- Add Azure Firewall  
- Convert to Terraform  
- Automate with Ansible  


## 🧹 Final Hygiene Cleanup

### Cleanup Performed

None during initial deployment  


### Recommended Cleanup

- Remove unused Public IPs  
- Delete failed deployments  
- Review quota usage  
- Remove unused NSGs  
- Clean temporary routing configurations  
