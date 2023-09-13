namespace EventPlanr.Domain.Exceptions;

public class EntityNotFoundException : Exception
{
    public EntityNotFoundException(string message) : base(message)
    {
    }

    public static EntityNotFoundException CreateForType<T>(Guid? entityId)
        => new($"Cannot find entity of type {typeof(T).Name}" + (entityId.HasValue ? $" with id={entityId}" : string.Empty));
}
