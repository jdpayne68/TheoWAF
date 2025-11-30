#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

echo "
<!doctype html>
<html lang=\"en\">
<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>Theo and his favorite girl Korra</title>
<link rel=\"stylesheet\" href=\"https://test-1256099743.s3.us-east-2.amazonaws.com/korra-website/styles.css\">
</head>
<body>
<div class=\"container\">
    <!-- Title Box -->
    <div class=\"title-box\">
        <h1>Theo and his favorite girl Korra</h1>
        <h2>AWS Instance Details</h2>
    </div>

    <!-- Picture Box -->
    <div class=\"picture-box\">
        <img src=\"https://test-1256099743.s3.us-east-2.amazonaws.com/korra-website/theo-korra.jpg\" alt=\"Samurai Katana\">
    </div>

    <!-- Metadata Box -->
    <div class=\"metadata-box\">
        <h3>Instance Information</h3>
        <div class=\"metadata-item\">
            <span class=\"metadata-label\">Instance Name:</span>
            <span class=\"metadata-value\">$(hostname -f)</span>
        </div>
        <div class=\"metadata-item\">
            <span class=\"metadata-label\">Private IP Address:</span>
            <span class=\"metadata-value\">${local_ipv4}</span>
        </div>
        <div class=\"metadata-item\">
            <span class=\"metadata-label\">Availability Zone:</span>
            <span class=\"metadata-value\">${az}</span>
        </div>
        <div class=\"metadata-item\">
            <span class=\"metadata-label\">VPC ID:</span>
            <span class=\"metadata-value\">${vpc}</span>
        </div>
    </div>
</div>
</body>
</html>
" > /var/www/html/index.html

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid