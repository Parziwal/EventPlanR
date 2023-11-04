namespace EventPlanr.ChatMessageResolver.Function.Models;
public class ChatMessageArguments
{
    public Guid ChatId { get; set; }
    public string? Content { get; set; } = null!;
}
