using EventPlanr.Application.Resources;

namespace EventPlanr.Application.Exceptions;

public class EntityNotFoundException : Exception
{
    public EntityNotFoundException()
    {
    }
    public EntityNotFoundException(string errorCode) : base(LocalizerManager.Localizer[errorCode])
    {
    }
}
