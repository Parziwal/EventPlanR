namespace EventPlanr.Application.Exceptions.Common;

public class ForbiddenException : Exception
{
    public ForbiddenException()
    {
    }

    public ForbiddenException(string errorCode) : base(errorCode)
    {

    }
}
