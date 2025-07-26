# ABP CLI Command with Disabled Multi-Tenancy

This guide shows you how to create an ABP application with multi-tenancy disabled using the ABP CLI.

## Prerequisites

1. **Install .NET SDK 8.0 or later**
   ```bash
   # For Ubuntu/Debian
   wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
   sudo dpkg -i packages-microsoft-prod.deb
   sudo apt-get update
   sudo apt-get install -y dotnet-sdk-8.0
   ```

2. **Install ABP CLI**
   ```bash
   dotnet tool install --global Volo.Abp.Cli --version 8.0.0
   ```

## Method 1: Manual Approach

### Step 1: Create ABP Project
```bash
~/.dotnet/tools/abp new YourProjectName --template app --ui blazor --database-provider ef --create-solution-folder
```

### Step 2: Disable Multi-Tenancy
Edit the file: `src/YourProjectName.Domain.Shared/MultiTenancy/MultiTenancyConsts.cs`

**Before:**
```csharp
public const bool IsEnabled = true;
```

**After:**
```csharp
public const bool IsEnabled = false;
```

## Method 2: Automated Script

Use the provided script to automatically create a project with multi-tenancy disabled:

```bash
# Make the script executable
chmod +x create-abp-no-multitenancy.sh

# Create a project with multi-tenancy disabled
./create-abp-no-multitenancy.sh YourProjectName
```

## Available ABP CLI Options

### Basic Command Structure
```bash
~/.dotnet/tools/abp new <project-name> [options]
```

### Common Options
- `--template app` - Application template (default)
- `--ui blazor` - Blazor UI framework
- `--ui mvc` - MVC UI framework
- `--ui angular` - Angular UI framework
- `--database-provider ef` - Entity Framework Core
- `--database-provider mongodb` - MongoDB
- `--create-solution-folder` - Create solution folder
- `--no-https` - Disable HTTPS
- `--skip-git` - Skip Git initialization

### Example Commands

**Blazor Application:**
```bash
~/.dotnet/tools/abp new MyApp --template app --ui blazor --database-provider ef
```

**MVC Application:**
```bash
~/.dotnet/tools/abp new MyApp --template app --ui mvc --database-provider ef
```

**Angular Application:**
```bash
~/.dotnet/tools/abp new MyApp --template app --ui angular --database-provider ef
```

## What Happens When Multi-Tenancy is Disabled

When you set `IsEnabled = false` in `MultiTenancyConsts.cs`:

1. **Tenant Management UI** - Tenant management pages are hidden
2. **Tenant Context** - All operations run in the host context
3. **Database** - No tenant-specific database operations
4. **Authentication** - Simplified authentication without tenant context
5. **Authorization** - Permissions work without tenant filtering

## Additional Configuration

### Remove Tenant Management Modules (Optional)

If you want to completely remove tenant management, you can remove these dependencies from your module files:

**From `MyProjectApplicationModule.cs`:**
```csharp
// Remove this line:
typeof(AbpTenantManagementApplicationModule),
```

**From `MyProjectDomainModule.cs`:**
```csharp
// Remove this line:
typeof(AbpTenantManagementDomainModule),
```

### Update Database Schema

After disabling multi-tenancy, you may need to update your database:

```bash
cd YourProjectName
dotnet ef migrations add DisableMultiTenancy
dotnet ef database update
```

## Running the Application

```bash
cd YourProjectName
dotnet restore
dotnet build
dotnet run --project src/YourProjectName.Blazor.WebApp
```

## Troubleshooting

### ABP CLI Not Found
If you get "command not found" for `abp`, use the full path:
```bash
~/.dotnet/tools/abp --version
```

### Migration Issues
If you encounter migration issues after disabling multi-tenancy:
1. Delete existing migrations
2. Create new initial migration
3. Update database

```bash
dotnet ef migrations remove
dotnet ef migrations add Initial
dotnet ef database update
```

## Benefits of Disabling Multi-Tenancy

1. **Simplified Architecture** - No tenant context management
2. **Better Performance** - No tenant filtering overhead
3. **Easier Development** - Simpler codebase
4. **Reduced Complexity** - Fewer moving parts
5. **Faster Startup** - No tenant resolution

## Summary

To create an ABP application with multi-tenancy disabled:

1. **Use the automated script:**
   ```bash
   ./create-abp-no-multitenancy.sh YourProjectName
   ```

2. **Or manually:**
   ```bash
   ~/.dotnet/tools/abp new YourProjectName --template app --ui blazor --database-provider ef
   # Then edit MultiTenancyConsts.cs and set IsEnabled = false
   ```

The application will be created with multi-tenancy disabled and ready to run!