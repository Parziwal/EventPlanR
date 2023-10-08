namespace EventPlanr.Application.Exceptions.Common;

public class DomainException : Exception
{
    public DomainException()
    {
    }
    public DomainException(string errorCode) : base(errorCode)
    {
    }
}
