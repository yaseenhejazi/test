using TestProject.Localization;
using Volo.Abp.AspNetCore.Components;

namespace TestProject.Blazor.WebApp.Tiered.Client;

public abstract class TestProjectComponentBase : AbpComponentBase
{
    protected TestProjectComponentBase()
    {
        LocalizationResource = typeof(TestProjectResource);
    }
}
