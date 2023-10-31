using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;
public class ChatMemberEntity : BaseEntity
{
    public Guid MemberUserId { get; set; }
    public DateTimeOffset LastSeen { get; set; }
    public Guid ChatId { get; set; }
    public ChatEntity Chat { get; set; } = null!;
}
