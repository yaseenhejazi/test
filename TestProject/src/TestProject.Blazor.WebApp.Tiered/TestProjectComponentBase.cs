using TestProject.Localization;
using Volo.Abp.AspNetCore.Components;

namespace TestProject.Blazor.WebApp.Tiered;

public abstract class TestProjectComponentBase : AbpComponentBase
{
    protected TestProjectComponentBase()
    {
        LocalizationResource = typeof(TestProjectResource);
    }
}
