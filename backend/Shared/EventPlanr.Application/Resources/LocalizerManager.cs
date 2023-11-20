using Microsoft.Extensions.Localization;

namespace EventPlanr.Application.Resources;

public static class LocalizerManager
{
    private static IStringLocalizer<EventPlanrApplication> _localizer = null!;

    public static IStringLocalizer<EventPlanrApplication> Localizer
    { 
        get { return _localizer; } 
    }

    public static void SetLocalizer(IStringLocalizer<EventPlanrApplication> localizer)
    {
        _localizer = localizer;
    }
}
