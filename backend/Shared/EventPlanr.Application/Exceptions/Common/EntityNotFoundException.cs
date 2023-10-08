namespace EventPlanr.Application.Exceptions.Common;

public class EntityNotFoundException : Exception
{
    public EntityNotFoundException()
    {
    }
    public EntityNotFoundException(string errorCode) : base(errorCode)
    {
    }
}
