using EventPlanr.Application.Resources;

namespace EventPlanr.Application.Exceptions;

public class ForbiddenException : Exception
{
    public ForbiddenException() : base(LocalizerManager.Localizer["ForbiddenException"])
    {

    }
}
