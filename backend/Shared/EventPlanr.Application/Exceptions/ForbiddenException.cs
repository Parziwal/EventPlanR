namespace EventPlanr.Application.Exceptions;

public class ForbiddenException : Exception
{
    public ForbiddenException()
    {
    }

    public ForbiddenException(string errorCode) : base(errorCode)
    {

    }
}
