namespace EventPlanr.ChatMessageResolver.Function.Models;
public class ChatMessageRequest
{
    public string Field { set; get; } = null!;
    public ChatMessageArguments Arguments { set; get; } = null!;
    public string UserId { set; get; } = null!;
}
