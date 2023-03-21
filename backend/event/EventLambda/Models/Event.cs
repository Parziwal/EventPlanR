using Amazon.DynamoDBv2.DataModel;
using Amazon.DynamoDBv2.DocumentModel;

namespace EventLambda.Models;

[DynamoDBTable("events")]
public class Event
{
    [DynamoDBHashKey("id")]
    public required string Id { get; set; }

    [DynamoDBProperty("name")]
    public required string Name { get; set; }

    [DynamoDBProperty("type")]
    public required string Type { get; set; }

    [DynamoDBProperty("imageUrl")]
    public required string ImageUrl { get; set; }

    [DynamoDBProperty("location")]
    public required string Location { get; set; }

    [DynamoDBProperty("date", typeof(DateTimeOffsetTypeConverter))]
    public required DateTimeOffset Date { get; set; }
}


public class DateTimeOffsetTypeConverter : IPropertyConverter
{
    public DynamoDBEntry ToEntry(object value)
    {
        DynamoDBEntry entry = new Primitive
        {
            Value = ((DateTimeOffset)value).ToUniversalTime().ToString(),
        };
        return entry;
    }

    public object FromEntry(DynamoDBEntry entry)
    {
        return DateTimeOffset.Parse(entry.AsString());
    }
}