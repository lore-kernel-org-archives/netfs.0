Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26420152DF7
	for <netfs@lists.linux.dev>; Fri, 21 Jun 2024 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950537; cv=none; b=b4Vk4jcUpAT7vMCDIgYeQfVxDQbdhGdhzwupA+anzsdGzy0gLvWUnTUf9HlA7Z8742UC86ISkKih9DcHLX5DZP3ibvefMR6WoshSaJ08mVJsA1kZDNp6tNTWepFgA89Dlwx0geKdDZo8iGdKecxbttYUU8bHUgvGy+RMFcWOn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950537; c=relaxed/simple;
	bh=4VTGbIy2c0wZ4RHqCElyIFME7bpYpp05SLreeje7vDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jjaTnbD14IWJMyC5xH7yS+1kQRbNJGZQ3ChY60HdzyfeMDihwrOszBCKLgFObe/h51ZgGXl3nsKN1RIPyJIj40J5n95JMdqoNDDxRbnuwR5sQIyRThaZThaAsz0kWYmokNLKE96bai2YgAP6rrXd9YKIve6heVjn4B5plGHRX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W56Rx0GDLzZcGh;
	Fri, 21 Jun 2024 14:11:09 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7694E18006E;
	Fri, 21 Jun 2024 14:15:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 14:15:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
CC: <linux-erofs@lists.ozlabs.org>, <netfs@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH 0/2] support query ondemand feature for erofs and cachefiles
Date: Fri, 21 Jun 2024 14:18:06 +0800
Message-ID: <20240621061808.1585253-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Hi all!

These two patches is used to support query ondemand feature
for erofs and cachefiles modules. Since erofs over fscache
introduces CONFIG_EROFS_FS_ONDEMAND and CONFIG_CACHEFILES_ONDEMAND,
we cannot know whether the kernel supports this feature or not
in userspace. So we introduce the sysfs interface for users'
applications to obtain this.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Hongbo

Hongbo Li (2):
  erofs: support query erofs ondemand feature by sysfs interface
  cachefiles: support query cachefiles ondemand feature

 fs/cachefiles/Makefile   |   3 +-
 fs/cachefiles/internal.h |   7 +++
 fs/cachefiles/main.c     |   7 +++
 fs/cachefiles/sysfs.c    | 101 +++++++++++++++++++++++++++++++++++++++
 fs/erofs/sysfs.c         |   6 +++
 5 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/sysfs.c

-- 
2.34.1

