# Business Central - Container Scripts

This repository contains PowerShell scripts to simplify the creation and license management of **Microsoft Dynamics 365 Business Central** containers using the **BCContainerHelper** module.

> Before running scripts, make sure you have the **BCContainerHelper** module installed by running in PowerShell:
>
> ```powershell
> Install-Module BCContainerHelper -Force
> ```
>
> To verify the installation, run:
>
> ```powershell
> Get-InstalledModule BCContainerHelper
> ```

## container-create.ps1

This script creates a new Business Central container with the specified parameters.

## container-import-license.ps1

This script imports a Business Central license into an existing container and restarts it.
