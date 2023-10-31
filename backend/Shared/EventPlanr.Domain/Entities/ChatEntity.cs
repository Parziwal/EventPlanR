using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class ChatEntity : BaseEntity
{
    public Guid? EventId { get; set; }
    public DateTimeOffset LastMessageDate { get; set; }
    public List<ChatMemberEntity> ChatMembers { get; set; } = new List<ChatMemberEntity>();
}
