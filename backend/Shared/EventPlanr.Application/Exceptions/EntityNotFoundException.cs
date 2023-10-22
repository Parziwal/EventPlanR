namespace EventPlanr.Application.Exceptions;

public class EntityNotFoundException : Exception
{
    public EntityNotFoundException()
    {
    }
    public EntityNotFoundException(string errorCode) : base(errorCode)
    {
    }
}
