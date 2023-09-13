namespace EventPlanr.Application.Dto.Common;

public class PageDataDto
{
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public string? OrderBy { get; set; }
    public OrderDirection? OrderDirection { get; set; }
}

public enum OrderDirection
{
    Ascending,
    Descending,
}
