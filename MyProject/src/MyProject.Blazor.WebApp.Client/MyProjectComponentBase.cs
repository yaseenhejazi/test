using MyProject.Localization;
using Volo.Abp.AspNetCore.Components;

namespace MyProject.Blazor.WebApp.Client;

public abstract class MyProjectComponentBase : AbpComponentBase
{
    protected MyProjectComponentBase()
    {
        LocalizationResource = typeof(MyProjectResource);
    }
}
