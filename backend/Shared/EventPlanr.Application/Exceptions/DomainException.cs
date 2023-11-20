using EventPlanr.Application.Resources;

namespace EventPlanr.Application.Exceptions;

public class DomainException : Exception
{
    public DomainException()
    {
    }
    public DomainException(string errorCode) : base(LocalizerManager.Localizer[errorCode])
    {
    }
}
