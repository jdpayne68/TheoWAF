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

# Get hostname
hostname_value=$(hostname -f)

cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>I love Lizzo</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #1a1a1a;
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
        }
        
        h1 {
            color: #000000;
            font-size: 3rem;
            margin-bottom: 10px;
            text-align: center;
            font-weight: 700;
        }
        
        h2 {
            color: #666666;
            font-size: 1.5rem;
            margin-bottom: 40px;
            text-align: center;
            font-weight: 500;
        }
        
        .hero-image {
            width: 100%;
            max-width: 800px;
            margin: 0 auto 40px;
            display: block;
            border-radius: 12px;
            border: 3px solid #000000;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
        }
        
        .details {
            background: #f5f5f5;
            border: 2px solid #333333;
            border-radius: 12px;
            padding: 30px;
            margin-top: 40px;
        }
        
        .details h3 {
            color: #000000;
            font-size: 1.5rem;
            margin-bottom: 20px;
            border-bottom: 3px solid #333333;
            padding-bottom: 10px;
            font-weight: 600;
        }
        
        .detail-item {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #cccccc;
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            font-weight: 600;
            color: #000000;
            min-width: 200px;
            font-size: 1rem;
        }
        
        .detail-value {
            color: #1a1a1a;
            font-family: 'Courier New', monospace;
            background: white;
            padding: 6px 14px;
            border-radius: 6px;
            border: 2px solid #333333;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>I love Lizzo</h1>
        <h2>AWS Instance Metadata</h2>
        
        <img src="https://giphy.com/embed/q45X7ovvaPm4u131qA">
        
        <div class="details">
            <h3>Instance Information</h3>
            <div class="detail-item">
                <span class="detail-label">Instance Name:</span>
                <span class="detail-value">${hostname_value}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Private IP Address:</span>
                <span class="detail-value">${local_ipv4}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Availability Zone:</span>
                <span class="detail-value">${az}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">VPC ID:</span>
                <span class="detail-value">${vpc}</span>
            </div>
        </div>
    </div>
</body>
</html>
EOF

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid