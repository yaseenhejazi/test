#!/bin/bash

# ABP CLI Command with Disabled Multi-Tenancy
# Usage: ./create-abp-no-multitenancy.sh YourProjectName

if [ -z "$1" ]; then
    echo "Usage: $0 <ProjectName>"
    echo "Example: $0 MyApp"
    exit 1
fi

PROJECT_NAME=$1

echo "Creating ABP project: $PROJECT_NAME"
echo "Multi-tenancy will be disabled automatically"

# Create the ABP project
~/.dotnet/tools/abp new $PROJECT_NAME --template app --ui blazor --database-provider ef --create-solution-folder

if [ $? -eq 0 ]; then
    echo "Project created successfully!"
    
    # Disable multi-tenancy
    MULTITENANCY_FILE="$PROJECT_NAME/src/$PROJECT_NAME.Domain.Shared/MultiTenancy/MultiTenancyConsts.cs"
    
    if [ -f "$MULTITENANCY_FILE" ]; then
        echo "Disabling multi-tenancy..."
        sed -i 's/public const bool IsEnabled = true;/public const bool IsEnabled = false;/' "$MULTITENANCY_FILE"
        echo "Multi-tenancy has been disabled!"
    else
        echo "Warning: MultiTenancyConsts.cs file not found. Please manually disable multi-tenancy."
    fi
    
    echo ""
    echo "Project '$PROJECT_NAME' has been created with multi-tenancy disabled."
    echo "You can now:"
    echo "1. cd $PROJECT_NAME"
    echo "2. dotnet restore"
    echo "3. dotnet build"
    echo "4. dotnet run --project src/$PROJECT_NAME.Blazor.WebApp"
else
    echo "Failed to create project!"
    exit 1
fi